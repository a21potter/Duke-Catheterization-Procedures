library(table1)
library(naniar)
library(tidyverse)
library(survminer)
library(survival)

cathr <- read.csv("dukecathr.csv")

# Overview of patient information
cathr$ACS <- factor(cathr$ACS, levels=c(0,1,2,3,4), labels=c("No ACS", "STEMI", "NSTEMI", "MI Unspecified", "UA"))
cathr$GENDER <- factor(cathr$GENDER, levels=c(0,1), labels=c("M", "F"))
cathr$RACE_G <- factor(cathr$RACE_G, levels=c(1,2,3), labels=c("Caucasian", "African American", "Other"))
cathr$INTVCATH <- factor(cathr$INTVCATH, levels=c(0,1), labels=c("No", "Yes"))
cathr$DIAGCATH<- factor(cathr$DIAGCATH, levels=c(0,1), labels=c("No", "Yes"))

table1(~ AGE_G + GENDER + RACE_G + DPCABG + DPPCI + DPMI + INTVCATH + DSSTROKE + DAYS2LKA | ACS, data = cathr, overall="Total")

# cathr %>% filter(INTVCATH=="Yes") %>% ggplot(aes(x = ACS, y = DPCABG)) +
#   geom_boxplot()
# cathr %>% filter(INTVCATH=="Yes") %>% ggplot(aes(x = ACS, y = DPPCI)) +
#   geom_boxplot()
# cathr %>% filter(INTVCATH=="Yes") %>% ggplot(aes(x = ACS, y = DPMI)) +
#   geom_boxplot()
# cathr %>% filter(INTVCATH=="Yes") %>% ggplot(aes(x = ACS, y = RSEQCATHNUM)) +
#   geom_boxplot()

# Recode DPPCI and DPCABG as most days since most recent intervention (DPINTV, TYPE_PRIOR)

cathr_intv <- cathr %>%
  filter(INTVCATH=="Yes") %>% filter(!is.na(DPCABG) | !is.na(DPPCI)) %>%
  mutate(DPINTV = case_when(is.na(DPCABG) | DPCABG > DPPCI ~ DPPCI,
                            is.na(DPPCI) | DPPCI > DPCABG ~ DPCABG,
                            DPCABG == DPPCI ~ DPCABG,
  )) %>%
  mutate(TYPE_PRIOR = case_when(is.na(DPPCI) | DPPCI > DPCABG ~ "CABG",
                                is.na(DPCABG) | DPCABG > DPPCI ~ "PCI",
                                DPCABG == DPPCI ~ "Both (same day)"
  ))

cathr_sub_intv <- cathr %>%
  filter(DIAGCATH=="Yes") %>% filter(!is.na(DSCABG) | !is.na(DSPCI)) %>%
  mutate(DSINTV = case_when(is.na(DSCABG) | DSCABG > DSPCI ~ DSPCI,
                            is.na(DSPCI) | DSPCI > DSCABG ~ DSCABG,
                            DSCABG == DSPCI ~ DSCABG,
  )) %>%
  mutate(TYPE_SUBSEQUENT = case_when(is.na(DSPCI) | DSPCI > DSCABG ~ "CABG",
                                is.na(DSCABG) | DSCABG > DSPCI ~ "PCI",
                                DSCABG == DSPCI ~ "Both (same day)"
  )) %>%
  mutate(DSINTV_CAT = case_when(DSINTV == 0 ~ 0,
                                DSINTV > 0 ~ 1))
cathr_sub_intv$DSINTV_CAT <- factor(cathr_sub_intv$DSINTV_CAT, levels=c(0,1),
                                    labels=c("Same day", "Later day"))

subj_max1 <- cathr_intv %>% group_by(RSUBJID) %>%
  summarise(max = max(RSEQCATHNUM, na.rm=TRUE))
subj_max2 <- cathr_sub_intv %>% group_by(RSUBJID) %>%
  summarise(max = max(RSEQCATHNUM, na.rm=TRUE))

final1 <- merge(cathr_intv, subj_max1, by.x = c("RSUBJID", "RSEQCATHNUM"), by.y = c("RSUBJID", "max"), all.y = T)
final2 <- merge(cathr_sub_intv, subj_max2, by.x = c("RSUBJID", "RSEQCATHNUM"), by.y = c("RSUBJID", "max"), all.y = T)

write_rds(final2, file = "dukecath_pre-processed.RDS")

# View variable counts and missing data

table1(~ AGE_G + GENDER + RACE_G + DSCABG + DSPCI + DSMI + DSSTROKE + DAYS2LKA | ACS, data = cathr_sub_intv, overall="Total")
gg_miss_var(df)

# EDA boxplot

final1 %>% ggplot(aes(x = ACS, y = DPINTV, fill = TYPE_PRIOR)) +
  geom_boxplot() +
  ylab("Days since closest preceding intervention") +
  xlab("ACS status at time of presentation") +
  scale_fill_discrete(name = "Type of closest\npreceding intervention")

final2 %>% ggplot(aes(x = ACS, fill = DSINTV_CAT)) +
  geom_bar(position="dodge") +
  ylab("Count") +
  xlab("Type of ACS at time of diagnostic cath.") +
  scale_fill_discrete(name = "Time of closest\nsubsequent intervention") +
  theme(axis.text.x = element_text(angle = 45))

data_clean %>% ggplot(aes(x = TYPE_SUBSEQUENT, fill = DSINTV_CAT)) +
  geom_bar(position="dodge") +
  ylab("Count") +
  xlab("Type of intervention") +
  scale_fill_discrete(name = "Closest\nsubsequent\nintervention") +
  theme(axis.text.x = element_text(angle = 45))

data_clean %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(NUMDZV)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(NUMDZV))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("No. of diseased vessels") +
  theme(axis.text.x = element_text(angle = 45))

df <- readRDS("dukecath_pre-processed.RDS") %>% filter(ACS %in% c("NSTEMI","UA") & TYPE_SUBSEQUENT != "Both (same day)")

surv.fit.gender = survfit(Surv(DAYS2LKA, DEATH) ~ GENDER, data=df)
ggsurvplot(surv.fit.gender, data=df, conf.int=F, pval=T, xlab="OS (days)")

surv.fit.race = survfit(Surv(DAYS2LKA, DEATH) ~ RACE_G, data=df)
ggsurvplot(surv.fit.race, data=df, conf.int=F, pval=T, xlab="OS (days)")

surv.fit.type = survfit(Surv(DAYS2LKA, DEATH) ~ TYPE_SUBSEQUENT, data=df)
ggsurvplot(surv.fit.type, data=df, conf.int=F, pval=T, xlab="OS (days)")

surv.fit.sameday = survfit(Surv(DAYS2LKA, DEATH) ~ DSINTV_CAT, data=df)
ggsurvplot(surv.fit.sameday, data=df, conf.int=F, pval=T, xlab="OS (days)")

surv.fit.diab = survfit(Surv(DAYS2LKA, DEATH) ~ HXDIAB, data=df)
ggsurvplot(surv.fit.diab, data=df, conf.int=F, pval=T, xlab="OS (days)")

surv.fit.smoke = survfit(Surv(DAYS2LKA, DEATH) ~ HXSMOKE, data=df)
ggsurvplot(surv.fit.smoke, data=df, conf.int=F, pval=T, xlab="OS (days)")


## EDA

library(ggcorrplot)
model.matrix(~0+., data=data_clean %>% select(c(TYPE_SUBSEQUENT, GENDER, RACE_G, HXMI, HXSMOKE, HXCEREB, HXDIAB))) %>%
  cor(use="pairwise.complete.obs") %>%
  ggcorrplot(show.diag = F, type="lower", lab=TRUE, lab_size=2)

library(ggpubr)
p1 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(NUMDZV)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(NUMDZV))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("No. of diseased vessels")
p2 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(HXCEREB)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(HXCEREB))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("History of cerebrovascular disease")
p3 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(HXDIAB)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(HXDIAB))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("History of diabetes")
p4 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(HXSMOKE)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(HXSMOKE))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("History of smoking")
p5 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(HXMI)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = as.factor(HXMI))) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("History of MI")
p6 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(GENDER)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = GENDER)) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("Gender")
p7 <- data_clean2 %>% filter(TYPE_SUBSEQUENT=="CABG" & !is.na(RACE_G)) %>% ggplot(aes(y = log(DSINTV + 0.1), x = RACE_G)) +
  geom_boxplot() +
  ylab("log(days + 0.1) to CABG") +
  xlab("Race") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

ggarrange(p1, p2 + rremove("y.text") + ylab(""), p3 + rremove("y.text") + ylab(""), p4 + rremove("y.text") + ylab(""), p5, p6+ rremove("y.text") + ylab(""), p7+ ylab(""),
          ncol = 4, nrow = 2)
