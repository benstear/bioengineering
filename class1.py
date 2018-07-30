#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  9 10:14:50 2018

@author: dawnstear
"""
import numpy as np

class Person(object):
    """ A class to create people
    
    Parameters
    ----------
    -dmat: distance matrix
    
    Attributes
    ----------
    
    Methods
    -------
    Details: prints details          """
    def __init__(self, name, age, ID, location, set_default_job="student"):  # must declare all possible attributes in __init__ constructor method
        # The constructor Method
        self.name = name
        self.age = age
        self.ID = ID
        self.location = location
        self.occupation = set_default_job
        
        
        # Check that attributes are correct type
        try:
            if not isinstance(self.name, basestring):
                raise ValueError("Parameter 'NAME' must be a string")
        except Exception as e:
                raise ValueError("Parameter 'NAME' must be a string")
                
        try:
            if not np.isscalar(self.age) or  (len(str(self.age)) is not 2): 
                raise ValueError("Parameter 'AGE' must be a 2-digit number")
        except Exception as e:
                raise ValueError("Parameter 'AGE' must be a 2-digit number")
                
        try:
            if not isinstance(self.ID,basestring) or  (len(str(self.ID)) is not 5): 
                raise ValueError("Parameter 'ID' must be a 5-digit string")
        except Exception as e:
                raise ValueError("Parameter 'ID' must be a 5-digit string")
        
        
        print("A person was instance was successfully created")
            
    
    def details(self):    
        print("Name: {}\nAge: {}\nID: {}".format(self.name,self.age,self.ID))
        print("Location: {}\nOccupation: {}\n".format(self.location,self.occupation))
    
print('Done!!!')
    
    