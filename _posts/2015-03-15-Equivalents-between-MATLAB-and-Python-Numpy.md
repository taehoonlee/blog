---
title: "Equivalents between MATLAB and Python Numpy"
categories: [tech, matlab]
tags: [MATLAB, MATLAB-numpy-equivalents, numpy]
---

지난달에 산학과제를 진행하면서 평소 잘 안 쓰던 Python을 꽤 많이 다루게 되었다. MATLAB에 익숙한 나에게 Python Numpy와 동일한 명령어들이 무엇인지 알아내는 것이 제일 중요했는데, 나는 그냥 몸으로 익힌 뒤에, 사람들이 나 같은 삽질을 하지 않았으면 하는 마음으로 equivalents 정리를 시작했다. 그런데 알고 보니 이 포스팅보다 더 완벽하게 정리 된 웹페이지가 있었다. 나도 처음부터 찾아볼 걸 하는 마음이 살짝 들었지만... 그래도 내 설명이 더 좋다!!라는 혼자만의 자신감으로 본문 시작!

- Let's Begin!!

Python

```python
>>> # this is Python shell
>>> # we need to import numpy
>>> import numpy as np
>>> # for linear algebra
>>> from scipy import linalg
>>> # for convolution
>>> from scipy import signal
```

MATLAB

```matlab
>> % this is MATLAB shell
```

- Create a matrix or a vector

Python

```python
>>> np.zeros(shape=(2,3))
array([[ 0.,  0.,  0.],
       [ 0.,  0.,  0.]])
>>> # "shape=" is usually omitted,
>>> # and will be omitted in this post!
>>> np.ones((3,2))
array([[ 1.,  1.],
       [ 1.,  1.],
       [ 1.,  1.]])
>>> np.random.random_sample((2,2))
array([[ 0.64432078,  0.03531748],
       [ 0.13467933,  0.45838312]])
>>> np.arange(5)
array([0, 1, 2, 3, 4])
>>> np.arange(2,7)
array([2, 3, 4, 5, 6])
>>> np.arange(2,7,2) # 3-rd number is an increment
array([2, 4, 6])
```

MATLAB

```matlab
>> zeros(2,3)
ans =
     0     0     0
     0     0     0
>> ones(3,2)
ans =
     1     1
     1     1
     1     1
>> rand(2,2)
ans =
    0.8147    0.1270
    0.9058    0.9134
>> 0:4
ans =
     0     1     2     3     4
>> 2:6
ans =
     2     3     4     5     6
>> 2:2:6 # middle number is an increment
ans =
     2     4     6
```

- Get a size of matrix

Python

```python
>>> mat = np.ones((4,3,2))
>>> mat.shape
(4, 3, 2)
>>> len(mat.shape)
3
>>> np.prod(mat.shape)
24
>>> mat.shape[0]
4
>>> mat.shape[1]
3
>>> mat.shape[2]
2
```

MATLAB

```matlab
>> mat = rand(4,3,2);
>> size(mat)
ans =
     4     3     2
>> numel(size(mat))
ans =
     3
>> numel(mat)
ans =
     24
>> size(mat,1)
ans =
     4
>> size(mat,2)
ans =
     3
>> size(mat,3)
ans =
     2
```

- Perform primitive operations

Python

```python
>>> A=np.array([[1,2],[3,4]]);
>>> B=np.array([[5,6],[7,8]]);
>>> np.dot(A,B) # matrix multiply
array([[19, 22],
       [43, 50]])
>>> A+B
array([[ 6,  8],
       [10, 12]])
>>> A-B
array([[-4, -4],
       [-4, -4]])
>>> A*B # element-wise multiply
array([[ 5, 12],
       [21, 32]])
>>> np.float64(A)/B # element-wise divide
array([[ 0.2       ,  0.33333333],
       [ 0.42857143,  0.5       ]])
>>> A**3 # element-wise exponentiation
array([[ 1,  8],
       [27, 64]])
>>> # concatenating matrices
>>> np.vstack([np.hstack([A,B]),
... np.arange(4)])
array([[1, 2, 5, 6],
       [3, 4, 7, 8],
       [0, 1, 2, 3]])
```

MATLAB

```matlab
>> A=[1 2;3 4];
>> B=[5 6;7 8];
>> A*B % matrix multiply
ans =
    19    22
    43    50
>> A+B
ans =
     6     8
    10    12
>> A-B
ans =
    -4    -4
    -4    -4
>> A.*B % element-wise multiply
ans =
     5    12
    21    32
>> A./B % element-wise divide
ans =
    0.2000    0.3333
    0.4286    0.5000
>> A.^3 % element-wise exponentiation
ans =
     1     8
    27    64
>> % concatenating matrices
>> [A B;0:3]
ans =
     1     2     5     6
     3     4     7     8
     0     1     2     3
```

- Perform linear algebra operations

Python

```python
>>> linalg.inv([[1,2],[5,7]])
array([[-2.33333333,  0.66666667],
       [ 1.66666667, -0.33333333]])
```

MATLAB

```matlab
>> inv([1 2;5 7])
ans =
   -2.3333    0.6667
    1.6667   -0.3333
```

- Perform convolutional operations

Python

```python
>>> A = np.arange(25).reshape(5,5)
>>> signal.convolve(A, np.ones((3,3)), 'same')
array([[  12.,   21.,   27.,   33.,   24.],
       [  33.,   54.,   63.,   72.,   51.],
       [  63.,   99.,  108.,  117.,   81.],
       [  93.,  144.,  153.,  162.,  111.],
       [  72.,  111.,  117.,  123.,   84.]])
>>> signal.convolve(A, np.ones((3,3)), 'valid')
array([[  54.,   63.,   72.],
       [  99.,  108.,  117.],
       [ 144.,  153.,  162.]])
```

MATLAB

```matlab
>> A = reshape(0:24,5,5)';
>> conv2(A, ones(3), 'same')
ans =
    12    21    27    33    24
    33    54    63    72    51
    63    99   108   117    81
    93   144   153   162   111
    72   111   117   123    84
>> conv2(A, ones(3), 'valid')
ans =
    54    63    72
    99   108   117
   144   153   162
```

더 많은 명령어들은 아래 페이지에 더 잘 정리되어 있다.

[http://wiki.scipy.org/NumPy_for_Matlab_Users](http://wiki.scipy.org/NumPy_for_Matlab_Users)
