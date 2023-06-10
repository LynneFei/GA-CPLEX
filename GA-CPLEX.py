# -*- coding: utf-8 -*-
"""
Created on Fri Jun  9 16:59:40 2023

@author: fleng
"""
import numpy as np

#c = np.fromfile('C_node10-S6.dat', dtype=int)

#print(c.isFuelStand)

def getVariableFromFile(variable_name, file_path):
    val = []
    startReading = False
    with open(file_path) as file:
        for line in file:
            if variable_name + ' =' in line:
                startReading = True
                continue
            if startReading and ';' in line:
                startReading = False
                break
            if startReading:
                temp_list = []
                for item in line:
                    if item not in ['[',']', ' ', '\n']:
                        temp_list.append(int(item))
                val.append(list(temp_list))
    return val

def setVariableInFile(variable_name, new_str_value, file_path):
    search_text = ''
    startReading = False
    with open(file_path) as file:
        data = file.read()
        print(data)
        # define text to replace
        for line in file:
            if variable_name + ' =' in line:
                startReading = True
                search_text = search_text + line
                continue
            if startReading and ';' in line:
                startReading = False
                break
            if startReading:
                search_text = search_text + line
        #data = data.replace(search_text, variable_name + ' = ' + new_str_value)
    
    print('here : -' + search_text + '-')
    with open(file_path, 'w') as file:
        #file.write(data)
        ...
     
# print(getVariableFromFile('isProTime', 'Model-1-GWP.dat'))
ifpro = np.random.randint(2, size = (12, 10))
str_val = '[' + ' '.join(map(str, ifpro[0])) + ']'
print(str_val)
setVariableInFile('isProTime', str_val, 'Model-1-GWP.dat')
        