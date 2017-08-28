# Anomaly Detection

Other names such as novelty and outliers detection.

S. Marsland, Novelty Detection in Learning Systems, Neural Computing Surveys, 2003.

Anomaly detection can be viewed as binary classification into normal and not-normal classes.  However, the prior probabilities of the two classes is usually extremely imbalanced, with the normal classes dominating over 90% of the cases.  This makes it difficult to obtain a large set of anomalous examples for both training and testing.  What are the implications for building an anomaly detection system?

What is the mathematical definition of an anomaly?

Threshold y = f(x) where larger y is more anomalous; need to learn f first.

## Approaches
  1. supervised, binary labels
  2. semi-supervised, normal data only
  3. unsupervised, fully unlabeled
