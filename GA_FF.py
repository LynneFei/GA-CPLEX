from PopulationFF import Population
#import numpy as np

pop_size = 12
chromosome_size = 10
top_n = 2
cross_rate = 0.6
mutation_rate = 0.001
elitism_radio = 0.3
population = Population(12, 10)

for i in range(1):
    
    population.fitness()
    population.select_chromosome(elitism_radio)
    population.cross_chromosome(cross_rate)
    population.mutation_chromosome(mutation_rate)
    best_individual, best_fit = population.best()
  
    print(population.fitness())
#    print(best_individual, best_fit)
