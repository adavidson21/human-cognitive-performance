# Identifying the Impact of Lifestyle Factors on Human Cognitive Performance Using Rule-Based Expert System

## Data Source

The data was sourced from Kaggle - [Human Cognitive Performance Analysis](https://www.kaggle.com/datasets/samxsam/human-cognitive-performance-analysis/data)

## Steps Completed for Analysis

1. Create a decision tree in Python using [scikit-learn](https://scikit-learn.org/stable).
   1. Generated 2 different models of different maximum depth to have both a deeper level analysis as well as one that selects a more manageable number of significant features for understanding the data.
2. Analyze the significant factors and create rules based off of our selection.
   1. Some rules were generated directly from the decision tree using scikit's [export_text](https://scikit-learn.org/stable/modules/generated/sklearn.tree.export_text.html) method which returns a list of the rules of the decision tree that was created.
3. Create rules and add them to a knowledge base built in Prolog.
4. Test the expert system that was built and identify if changes should be made to the model by reevaluating the signficant features that were selected.