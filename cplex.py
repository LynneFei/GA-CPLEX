from doopl.factory import *

# Data


# Create an OPL model from a .mod file
with create_opl_model(model="Centralized-node10-S6.mod",data="C_node10-S6.dat") as opl:
    # tuple can be a list of tuples, a pandas dataframe...
  #  opl.set_input("buses", Buses)

    # Generate the problem and solve it.
    opl.run()
