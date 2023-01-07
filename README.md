# Instructions

This README corresponds to Case Study 1 regarding the NBA Last Two Minute Report.
**Read this file carefully.**

### Deadline and submission

Report and reproducible code for the initial submission will be due on
**Tuesday, November 22**. Final case team submission and formal response 
to review will be due on **Friday, December 9** (note - this is the last day
of class. I can't extend the due date due to university policy). You will be 
asked to confidentially evaluate your team members after the final case team 
submission.

There is a **length limit of 8 pages** (*including* tables and figures for the
report. Supplemental figures/tables and other information may be provided in an
appendix following the main text.

You must submit a .pdf document to Gradescope that corresponds to an .Rmd file
on your GitHub repository in order to receive credit for this case study. If one
is not uploaded to Gradescope by the submission deadline, your latest commit 
prior to the deadline will be used as your submission. 

Your team's GitHub repository and commit history will also be evaluated by the 
instructor. The GitHub repository must contain the reproducible R Markdown 
document corresponding to the submitted reports, and will be checked throughout 
the course of the case study to ensure all team members are making meaningful
contributions to the project. Insufficient individual contribution as based on
the anonymous case team review and commit history **will** result in grade
reductions (it's happened before. No one's happy).

### Guidelines

- This is an team assignment, with teams randomly assigned by the instructor.
- Everything in your repository is for your team's eyes only except for the 
instructor or TAs.
- As always, you must cite any code you use as inspiration. A failure to cite is
plagiarism.

### Academic integrity

By submitting an assignment, you pledge to uphold the Duke Community Standard:

- I will not lie, cheat, or steal in my academic endeavors;
- I will conduct myself honorably in all my endeavors; and
- I will act if the Standard is compromised.

# Data 

See accompanying files in the repository for information regarding the data.
Note that these data have been randomly permuted such that they data are
not original, but are *representative* of the original data (such that no 
publications can arise from use of these data) in terms of the clinical
conclusions that can be made. 

**You may treat these data as if they were original for case study purposes**.

# Grading policy

Upon initial report submission, you will be provided feedback and a numeric
grade. You will receive feedback from the instructor and TAs regarding
your submission and have the opportunity to submit a final report. This
final submission must be accompanied by a formal response to the peer review. 
Your final assigned grade for Case 1 will be the average of your initial
submission and final submission.

A more detailed discussion of grading considerations is available after this
overview. The final report is worth 100 points, broken down as follows:

| Component    | Points |
|--------------|--------|
| Introduction | 20     |
| Methodology  | 40     |
| Results      | 20     |
| Discussion   | 20     |

You may create sub-headings as you like, but you must have these four 
components in your final report. 

Any grade deductions in appendices will be allocated to their appropriate
sections. For instance, appendix figures evaluating model assumptions may
impact points corresponding to Methodology and Results. Appendix figures 
displaying exploratory analyses or data cleaning steps may impact points
corresponding to Introduction, etc. Interpretation of model coefficients,
regardless of where they appear in the manuscript, will correspond to the
Results section.

There may additionally be grade deductions for overall paper issues. For  
instance, make sure the paper is professionally presented and free of 
distracting errors or other issues such as poor organization, problems 
with grammar, spelling, or punctuation, and layout concerns such as small 
font in visuals, excessive and inappropriate decimal points, etc. (this 
is not an exhaustive list!).

Submissions missing a formal response to peer review will receive an
automatic penalty of 20 points on the final submission. Any submissions 
missing code used for the manuscript in the GitHub repository will 
automatically receive a score of 0 points. Again, your individual grade 
may be modified due to team evaluation and instructor assessment of 
relative contribution to GitHub repository.

### Introduction

The introduction should introduce your general research question and your data
(where it came from, how it was collected, what the observational unit is, 
which variables were used in the analysis, etc. Feel free to create subsections 
as needed (for instance, for the dataset, any exploratory visualizations, etc.). 

In evaluating your introduction, I will be evaluating the following points:

- Is/are the main goal(s) of the analysis easy to identify and appropriate for
addressing the overall research problem?
- Is the rationale for the data analysis explained well?
- Does the manuscript describe the context/background of the work and its 
relation to existing literature?
- Are the variables (response and predictors) clearly identified and discussed?
- Does the manuscript explain how the data were collected and/or how they were
derived?
- If provided, is any EDA helpful and informative in addressing the main 
project goal(s)?

### Methodology

The methodology section should clearly explain the model(s) used in your 
analysis. You must clearly state your model formulation using appropriate
mathematical notation and justify their use, and address any model assumptions 
or diagnostics needed. 

In evaluating your methodology, I will be evaluating the following points:

- Is the proposed analysis appropriate given the main goal(s) and dataset?
- Why was this particular methodology chosen over competing choices?
- Are the specific methods described in enough detail that the work could be
replicated by other researchers *without* access to the original analysis code?
- Is it clear which approaches/models were used to evaluate specific goals?
- What assumptions are needed for the model(s), and how do you plan to assess
whether they hold?
- What sensitivity analyses, if any, are planned, and how do they relate to your
analysis approach?

You may include technical derivations and evaluation of model diagnostics and
assumptions in the appendix to your manuscript; they do not belong in the body
of your work.

### Results

Showcase your results. Provide model output (such as coefficient estimates and
quantification of uncertainty) in tabular and/or visual format. Make sure that
each set of results presented supports the goal(s) of your manuscript.

In evaluating your results, I will be evaluating the following points:
 
- Are tables formatted cleanly and precisely? Do visualizations follow good
practices (e.g., clean axis labels, clear titles, appropriate figures given
data types, etc.)?
- Do tables/figures refer to raw variable names, or are all references clearly
made in context of the data?
- Are appropriate conventions re: formatting (e.g., an acceptable number of
decimal places, table/figure captions, etc.) followed when displaying results?
- Is there an appropriate quantification of uncertainty of estimates?
- Are all results interpreted correctly? 

### Discussion

Discuss the implications your results have in terms of your goal(s) and research
question(s). As well, provide a reasoned critique of your methodology and 
provide suggestions for improving the analysis or what additional data might
have strengthened the paper. 

In evaluating your discussion, I will be evaluating the following points:

- How do your results address or fail to address the goal(s) of your manuscript?
- Does the manuscript provide clear, correct, and effective interpretation of
the analysis results?
- Are all conclusions made directly supported by the results?
- Was your methodology fully appropriate? What alternative techniques might have
been useful?
- Are there any issues with reliability or validity of the data?
- What would you do differently if you had to approach the study again? What
additional data sources, variables, or techniques might help you create a 
stronger manuscript?

### Appendix

Here you may present any technical derivations (if needed) and demonstrate
that the assumptions for your models are met. Examples of derivations might
include explicit variance terms of frequentist estimators or derivation of
full conditional distributions for Gibbs samplers, etc.

As for examples of assumptions, if you are creating a linear model, this would be
a good place to discuss the assumptions (e.g., by providing residual plots and
comments); if you are performing a Bayesian analysis, this would be a good place
to show diagnostic plots (e.g., trace plots, etc.). This section may be as long 
or as short as needed. 

### Repository

The instructor will also evaluate whether the commit history is appropriate and
contains clear descriptions of each committed change. This repository must
contain all code used, as well as any ancillary external files which you may
have used in your analysis. All team members must make significant 
contributions to the GitHub repository; lack of contribution is grounds for
a potentially lower grade compared to other team members.

The final .pdf report must be typeset and reproducible from your analysis code
(end-to-end scripting). This .pdf must match your submission to Gradescope. As
well, any slides used for your video presentation should also be included. If
these slides were generated using a reproducible method (such as xaringan or
Beamer), you must include the code used as well.

**Unsatisfactory repositories will result in group and/or individual grade reductions.**

### Tips

- **Make sure you are addressing the case study goals.**
- Clearly state your hypothesis (or hypotheses) - think about how your paper
might create actionable insight for others.
- Make sure you use best visualization practices as discussed in class for all
visualizations and/or tables.
- Write clearly and effectively; confusing the reader is never a good thing!
- Quality over quantity - do not calculate every statistic and procedure you 
have learned for every variable, but rather choose the most *appropriate*
technique or set of techniques to address the goal at hand.
- Focus on methods that help you begin to answer your research questions.

# Grade considerations:

Note that simply “not making any errors” isn’t enough to get full points 
on an assignment - that is the baseline expectation! In line with Duke 
grade considerations, work earning an A is truly exceptional, and 
demonstrates fluent mastery of the statistical issues and presents 
convincing, well-organized results in a clear and appropriate way. Work
earning a B suggests superior understanding of the material, but may have 
some minor issues in its approach or communication. Work earning a C is
satisfactory and suggests adequate understanding - this is the baseline 
expectation. 

I will go over common errors and mistakes in class, and we will critique
existing papers and prior student work that demonstrate common errors. Some
of these errors include things like writing "p = 0.000," having raw variable
names in the final manuscript or tables, misinterpreting regression 
coefficients (e.g., not conditionally on other variables in the model or
mentioning some notion of expectation, if that is what you are examining),
misinterpreting frequentist p-values (e.g., affirming frequentist null 
hypotheses), or erroneous causal language given observational data.
