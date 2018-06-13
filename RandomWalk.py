#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 11 18:41:45 2018

@author: benstear
"""
# Random Walk Generator to answer the following question:
    # What is the longest random walk you can take so
    # so that on average you'll end up 4 blocks or less from home (0,0)?
    
    # Use Monte Carlo simulation
import random
import numpy as np
import matplotlib.pyplot as plt
'''
def random_walk(n): 
    """ Return Coordinates after 'n' block random walks
        Parameter(s):
        n = integer, number of random steps taken.    """ 

    x,y = 0,0
    for i in range(n):
        (dx,dy) = random.choice([(0,1), (0,-1), (1,0), (-1,0)])
        x +=dx
        y +=dy
    return (x,y)


number_of_walks = 10000
no_trans_vector = range(79)

for walk_length in range(1,80):
    no_transport = 0 # Number of walks 4 or fewer from home
    for i in range(number_of_walks):
        (x,y) = random_walk(walk_length)
        distance = abs(x)+abs(y)
        if distance<=4:
            no_transport+=1
    no_transport_percentage = 100*(float(no_transport)/ number_of_walks)
    print("Walk size = ",walk_length, "/ % of no transport = ", no_transport_percentage)    
    no_trans_vector[walk_length-1] = no_transport_percentage    
      
Length_of_walk = range(79)

plt.plot(Length_of_walk, no_trans_vector)
plt.ylabel('Average (n = 20,000) Distance From Home')
plt.xlabel('Number of Random Steps') 
plt.show()


def disp_walk(n):
    x,y = 0,0
    for i in range(n):
        (dx,dy) = random.choice([(0,1), (0,-1), (1,0), (-1,0)])
        x +=dx
        y +=dy
    return (x,y)
       '''
       
       
       
       
       
       
# left right left right       
       
print("*")
print("*")
print("*")
print("* * *")


import turtle

turtle.speed('slowest')

walk = randomWalkb(25)

for x, y in zip(*walk):
    #multiply by 10, since 1 pixel differences are hard to see
    turtle.goto(x*10,y*10)

turtle.exitonclick()
    
    





    

