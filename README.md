# EvolutionaryAlgorithm
The objective of this project is to implement an evolutionary algorithm framework that finds the best straight line passing through the origin of a coordinate plane, dividing a set of triple input data (x, y, c) from the "input.txt" file into two separate groups based on their class labels (1 or 2). where (x,y) represents a point on the coordinate plane and c is the class label.
## Input: 
input.txt
## Output: 
 1) The plot displays points from two distinct classes, with each class represented by a unique shape. Additionally, the algorithm has successfully identified the separating line that effectively divides the classes. 
 2) The progress of fitness
The program is written in Matlab. To change the parameter of the algorithm you can modify the first lines of the program:
%======================================
%change parameters here 
    np=6;
    parentNum=3;
    epoch=20;
    data=load ('input.txt'); 
%======================================
- np=6: the number of population is considered to be 6 (the reason of selecting a small np is to show the performance of the evolutionary algorithm. Otherwise, in most cases, the answer is reached within 1 or 2 iterations)
- parentNum=3: the number of the population that are selected as parents 
- epoch=20: the maximum number of repetitions (it stops if the answer is reached before this number of repetitions)
- data=load ('input.txt'): if you want to change the input file, change the desired file name in this line)
There are two samples of prepared datasets named input.txt and input1.txt (each containing about 125 input data) that you can use as input samples.

    

