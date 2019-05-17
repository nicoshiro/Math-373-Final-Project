import numpy as np

# Function that evaluates f -> we are trying to minimize this
def eval_f(beta, X, Y):
    numExam, numFeat = X.shape
    numExam, numClasses = Y.shape
    
    cost = 0.0
    
    for i in range(numExam):
        xi = X[i,:]
        yi = Y[i]
        
        dotProds = xi @ beta
        
        terms = np.exp(dotProds)
        probs = terms/np.sum(terms)
        
        k = np.argmax(yi)
        cost += np.log(probs[k])
        
    return -cost

# Function that evaluates the full gradient for normal MCL regression
def eval_grad(beta, X, Y):
    numExam, numFeat = X.shape
    numExam, numClasses = Y.shape
    
    grad = np.zeros((numFeat, numClasses))
    probs = np.zeros(numClasses)
    
    for i in range(numExam):
        
        xi = X[i, :]
        yi = Y[i]
        
        gradi = np.zeros((numFeat,numClasses))
        dotProds = xi @ beta
        terms = np.exp(dotProds)
        probs = terms/np.sum(terms)
        
        for k in range(numClasses):
            gradi[:, k] += (probs[k] - yi[k]) * xi
            
        grad += gradi
            
    return grad


# Function that performs MCL regression with the full gradient
def multiclassLogReg_grad(X, Y, t):
    maxIter = 300
    
    numExam, numFeat = X.shape
    numExam, numClasses = Y.shape
    
    beta = np.zeros((numFeat, numClasses))
    costs = np.zeros(maxIter)
    
    for idx in range(maxIter):
        grad = eval_grad(beta, X, Y)
        beta = beta - t * grad
        costs[idx] = eval_f(beta, X, Y)
        print("id: " + str(idx) + "cost: " + str(costs[idx]))
        
        
    return(beta, costs)

# Function that only evaluates gradi and is used for SGD
def eval_gradi(beta, xi, yi):
    numFeat = len(xi)
    numClasses = len(yi)
        
    gradi = np.zeros((numFeat,numClasses))
    dotProds = xi @ beta
    terms = np.exp(dotProds)
    probs = terms/np.sum(terms)
        
    for k in range(numClasses):
        gradi[:, k] += (probs[k] - yi[k]) * xi
            
    return gradi


# Function that evaluates MCL regression using SGD -> used on the MNIST dataset
def multiclassLogReg_SGD(X, Y, t):
    numEpochs = 25
    
    numExam, numFeat = X.shape
    numExam, numClasses = Y.shape
    
    beta = np.zeros((numFeat, numClasses))
    costs = np.zeros(numEpochs)
    
    for epoch in range(numEpochs):
        for i in np.random.permutation(numExam):
            xi = X[i, :]
            yi = Y[i]
            
            gradi = eval_gradi(beta, xi, yi)
            beta = beta - t * gradi
        cost = eval_f(beta, X, Y)
        costs[epoch] = cost
            
        # print("epoch: " + str(epoch) + "cost: " + str(cost))
            
    return(beta, costs)
