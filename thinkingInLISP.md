# Thinking in LISP

The code in this repository deals with the following problem:

```
Given a list of items of arbitrary length, produce all possible sequences
of arbitrary length n. 
```

For example, you could be given a list of "Rock", "Paper" and "Scissors", 
and you would then have to find all possible sequences that could be created
of say length 2 which would be: 

```
("Rock" "Rock"), ("Rock" "Paper"), ("Rock" "Scissors"), ("Paper" "Rock"),
("Paper" "Paper"), ("Paper" "Scissors"), ("Scissors" "Rock"),
("Scissors" "Paper"),("Scissors" "Scissors")
```

To reiterate, the code allows us to do this for a list of arbitrary size, and n, a natural number, of arbitrary size.  

I published this code and my thought process in the comments to help people see how LISP/Scheme/Racket programmers think through problems. 

Why would I want to show how a LISP programmer thinks through code? 

Paul Graham wrote an article entitled, "Beating the Averages." In the article he talks about some of the advantages of knowing LISP. He talks about how programming languages shape your thinking. Here are some quotes from the [article](http://www.paulgraham.com/avg.html):


```
"What's so great about Lisp? And if Lisp is so great, why doesn't everyone use it? These sound like rhetorical questions, but actually they have straightforward answers. Lisp is so great not because of some magic quality visible only to devotees, but because it is simply the most powerful language available."
```

```
"Ordinarily technology changes fast. But programming languages are different: programming languages are not just technology, but what programmers think in. They're half technology and half religion."
```

```
"By induction, the only programmers in a position to see all the differences in power between the various languages are those who understand the most powerful one. (This is probably what Eric Raymond meant about Lisp making you a better programmer.)"
```

```
"Ordinarily technology changes fast. But programming languages are different: programming languages are not just technology, but what programmers think in. They're half technology and half religion."
```


I hope that this code and "thought comments" can help others see what it is like to think in the LISP family of languages. In this case I use Racket which a variant from the LISP family. 


In the code "thought comments" you will see the use of Data-Driven Templates and Type Comments (derived from Type Theory). 

What do these mean? 

Type Comments give us a high-level model of the structure of the data. Type Comments then lead to quasi-functions, which are called Data-Driven Templates or Templates for short. We can then use these Data-Driven Templates as the backbone of our functions. Another way to think of Templates is that they are analagous to the initial foundation of a house. Once you have the foundation built you can then reason about the hard parts of your function's design. 

Data-Driven Templates give you a "box" to build out from. As Stanford Psychologist Chip Heath says, ["A good box is like a lane marker on the highway: It’s a constraint that liberates."](https://www.fastcompany.com/61175/get-back-box) 

For more on Data-Driven Design and Type Comments see the work of [Felleisen, et al](http://www.ccs.neu.edu/home/matthias/HtDP2e/part_preface.html)


## LISP Macros:

I do not go over LISP Macros in this code. [Here is an excellent introduction on LISP Macros.](https://stackoverflow.com/questions/267862/what-makes-lisp-macros-so-special) 


## Getting Started

The goal of this repo is to show an example of a way of thinking. Reading and working through the "thought comments" in the code file, is the best way to do this. You can also run the file, and play with it. Details below. 

### Prerequisites
Please note: you will have to familiarize yourself with LISP syntax. 
A good place to see the difference between Python and LISP, is [Peter Norvig's article on Python for Lisp Programmers.](http://norvig.com/python-lisp.html)


### Installing

Install the Racket programming language from [here.](https://racket-lang.org/)

Then you can run the file or any file with the rkt extension. 


## Running the tests

All the tests, i.e. the check-expect statements will can be run, 
by pressing the run button on the Racket IDE installed as above. 


## Authors

* Saumitra Saha


## License

This project is licensed under the MIT License

## Acknowledgments

I would like to give special thanks to Atopos from UBCx for helpful comments. Also a special thanks to [Gregor Kiczales at UBCx](https://www.edx.org/course/how-code-simple-data-ubcx-htc1x), [Matthias Felleisen and the HtDP group](http://www.ccs.neu.edu/home/matthias/HtDP2e/part_preface.html) for creating courses and books on how to think in a systematic, data-driven way. 



