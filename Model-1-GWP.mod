/*********************************************
 * OPL 12.7.1.0 Model
 * Author: Linfei Feng
 * Creation Date: Sep 29, 2021 at 2:33:40 PM
 *********************************************/

 execute PARAMS {
	cplex.tilim = 3600; 
//   cplex.epgap = 0.01;
 	cplex.mipkappastats = 2;
 	cplex.EpMrk = 0.99;
 	cplex.datacheck = 1;
//	cplex.parallelmode = 1;
	//cplex.ScaInd = 1;
//	cplex.numericalemphasis = 1;
// 	cplex.randomseed = 2018;
 } 

 // record the start time								
 float temp;
 execute{
 var before = new Date();
 temp = before.getTime();
 }

  //// parameters
 
 // t: the set of time period
 int period = ...;
 range timePeriod = 1..period;
 
  int period2 = ...;
 range timePeriod2 = 2..period2;
 //{string} timePeriod = ...;

 // i: the set of hydrogen physical form
 {string} hydForm = ...;

 // e: the set of feedstock type
 {string} feedType = ...;
 
// p: the set of production plant technology
 {string} prodTech = ...; 
 
 // jp: the set of production facility size
 {string} prodSize = ...;
 
 // js: the set of storage facility size
 //{string} stoSize = ...;
 
 // jf: the set of fueling facility size
 {string} fuelSize = ...;

 // ojf: the set of fueling facility size
 {string} onsiteFuelSize = ...;
 
 // fs: the set of standard fueling station technology
 {string} standFuelTech = ...; 
 
 // fo: the set of on-site fueling station technology 
 {string} onsiteFuelTech = ...; 
 
 // n,m: the set of node
 int numNode = ...;
 range node = 1..numNode;
 
 // q: the set of OD pair
// int numPair = ...;
// range pair = 1..numPair; 

 // the hydrogen fueling demand flow of each node
 float hydFuelDem[node][timePeriod] = ...;
 
 // the set of feedstock transport mode
 tuple tranFeedT {
 
 string feedType;
 string transpMode; 
 int	driverWage; // $/h
 float	fuelEco; // fuel economy, km/l
 float	fuelPrice;// $/l
 float	genEx; // general expenses, $/d
 int	loUnloTime; // load unload time, hr
 float	maintEx; // maintenance expenses, $/km
 int	speed;// km/hr
 int	tranAva; // transportation availability, hr/d
 int  tranCap; // transportation capacity of a single vehicle, kg/trip
 int  vehRentCost; // transportation vehicle rent cost, $/d
 
 };
 
 {tranFeedT} tranFeed=...;
 
 // upper and lower limit of feedstock transport capacity between two nodes, kg/d
 int feedTranCapaMax[tranFeed] = ...;
 int feedTranCapaMin[tranFeed] = ...; 
 
  // ep: the set of feedType-prodTech combination
 tuple feedProdT {
 
 string feedType;
 string prodTech;
 float converRate; // unit e/kg H2
  
 };
 
 {feedProdT} feedProd = ...; 
  
//  // c: the converage rate of onsitefeedstock
// float converRate[feedType] = ...;

 //efo: the set of feedType-onsiteFuelTech combination
 tuple feedOnsiteFuelT {
  
 string feedType;
 string onsiteFuelTech;
 float converRate; // unit e/kg H2
 };
 
 {feedOnsiteFuelT} feedOnsiteFuel = ...; 
 
// // oc: the converage rate of onsitefeedstock
// float onsiteconverRate[feedType] = ...;
 
 //float feedOnsiteFuel = ...;
 
 // the set of hydrogen transport mode(Second)
// tuple tranHydT2 {
// 
// string hydForm;
// string transpMode; 
// int	driverWage; // $/h
// float	fuelEco; // fuel economy, km/l
// float	fuelPrice;// $/l
// float	genEx; // general expenses, $/d
// int	loUnloTime; // load unload time, hr
// float	maintEx; // maintenance expenses, $/km
// int	speed; // km/hr
// int	tranAva; // transportation availability, hr/d
// int  tranCap; // transportation capacity of a single vehicle, kg/trip
// int  vehPurCost; // transportation vehicle rent cost, $/d
// float  emiFac; // emission factor, kg CO2/l
// };
// 
// {tranHydT2} hydForm=...;
 
 
 int driverWage = ...;
 float	fuelEco = ...;
 float	fuelPrice = ...;
 float	genEx = ...;
 int	loUnloTime = ...;
 float	maintEx = ...;
 int	speed = ...;
 int	tranAva = ...;
 int  tranCap [hydForm] = ...;
 int  vehPurCost [hydForm] = ...;
 

 // upper and lower limit of hydrogen transport capacity between two nodes, kg/d (Second)
 int hydTranCapaMax2 [hydForm] = ...;
 int hydTranCapaMin2 [hydForm] = ...;
 
 // upper and lower limit of hydrogen direct transport capacity between two nodes, kg/d (direct)
// int hydTranCapaDirMax [tranHyd1] = ...;
// int hydTranCapaDirMin [tranHyd1] = ...;

 // transportation vehicle Purchase cost, $///d
 //int  tranCapCost [tranHyd] = ...; 

 // annual network operating period, d/y
 int opePeriod = ...; 
 
 // payback period of capital investment, y
 //int payPeriod = ...;	 

 // upper and lower limit of feedstock supply capacity at each node, unit/d
 int feedSupCapaMax[node][feedType] = ...;
 int feedSupCapaMin[node][feedType] = ...;
 
 // capital cost of a production plant, $
// int prodCapCost[prodTech][hydForm][prodSize][timePeriod] = ...;
 int prodCapCost[prodTech][hydForm][prodSize] = ...;
 // operating cost of a production plant, $/kg
 float  prodOpeCost[prodTech][hydForm][prodSize] = ...;	

 // upper and lower limit of production capacity, kg/d
 int	prodCapaMax[prodTech][hydForm][prodSize] = ...;	 
 int	prodCapaMin[prodTech][hydForm][prodSize] = ...;
 
 // capital cost of a standard fueling station, $S
 int standFuelCapCost[standFuelTech][hydForm][fuelSize] = ...;

 // operating cost of a standard fueling station, $/kg
 float  standFuelOpeCost[standFuelTech][hydForm][fuelSize] = ...;

 // upper and lower limit of standard fueling capacity
 int	standFuelCapaMax[standFuelTech][hydForm][fuelSize] = ...;
 int	standFuelCapaMin[standFuelTech][hydForm][fuelSize] = ...;
 
  // upper and lower limit of terminal capacity, kg/d
 int	terCapaMax[hydForm][prodSize] = ...;	 
 int	terCapaMin[hydForm][prodSize]= ...;
 
 // capital cost of a onsite fueling station, $
 int	onsiteFuelCapCost[onsiteFuelTech][onsiteFuelSize] = ...; 
 
 // operating cost of a onsite fueling station, $/kg	
 float  onsiteFuelOpeCost[onsiteFuelTech][onsiteFuelSize] = ...;
													  
 // upper and lower limit of onsite fueling capacity
 int	onsiteFuelCapaMax[onsiteFuelTech][onsiteFuelSize] = ...; 
 int	onsiteFuelCapaMin[onsiteFuelTech][onsiteFuelSize] = ...;
 
 // the shortest distance between two different nodes, km
 int	distOD[node][node] = ...;	
 
 // transportation operating cost (hydrogen)
 //float hydTranOpeCost[hydForm]  = ...;   	
 //************************************************************************************************************************
 // ir: the inflation rate
 //float ir = ...;
 
 // d: the discount rate
 //float d = ...;  
 
 // N: the length of the analysis period
 //int N = ...;
 
 // tax: total tax rate
 //float tax = ...;
 
 // capital cost of a hydrogen terminal
 float strCapCost[hydForm][prodSize] = ...;
 // operating cost of a hydrogen terminal $/d
 float strOpeCost[hydForm][prodSize] = ...;	
 
 // the type of feedstock and utility
 {string} feedUti = ...;
 
 //the amounts of feedstock and utility requirement for different onsite fueling technology
 float feedReqOnsiteFulTech[onsiteFuelTech][feedUti] =...;
 
 //the amounts of feedstock and utility requirement for different production technology
 float feedReqProdTech[prodTech][hydForm][feedUti] =...;
 
 //the amounts of feedstock and utility requirement for different hydrogen terminal
 float feedReqHydTer[hydForm][feedUti] =...;
 
 //the amounts of feedstock and utility requirement for fueling station
 float feedReqFueSta[hydForm][feedUti] =...;
 
 //the amounts of feedstock and utility requirement for onsite fueling station
 float feedReqOnsiteFueSta[onsiteFuelTech][feedUti] =...;
 
 // the amount of CO2 upstream emissions for different feedstock and utility
 float upsEmiCO2[feedUti] =...;
 
 //the amount of on-site CO2 emissions for different production technology
 float onsitEmiProdTechCO2[prodTech] =...;
 
 //the amount of on-site CO2 emissions for different hydrogen terminal
 float onsitEmiHydTerCO2[hydForm] =...;
 
 //the amount of on-site CO2 emissions for different hydrogen transportation (first)
// float onsitEmiHydTranCO2_1[tranHyd1] =...;
 
 //the amount of on-site CO2 emissions for different hydrogen transportation (Second)
 float onsitEmiHydTranCO2_2[hydForm] =...;
 
 //the amount of on-site CO2 emissions for different fueling station
 float onsitEmiFueStaCO2[hydForm] =...;
 
 // the amount of upstream CH4 emissions for different feedstock and utility
 float upsEmiCH4[feedUti] =...;
 
 //the amount of on-site CH4 emissions for different production technology
 float onsitEmiProdTechCH4[prodTech] =...;
 
 //the amount of on-site CH4 emissions for different hydrogen terminal
 float onsitEmiHydTerCH4[hydForm] =...;
 
 //the amount of on-site CH4 emissions for different hydrogen transportation(first)
// float onsitEmiHydTranCH4_1[tranHyd1] =...;
 
 //the amount of on-site CH4 emissions for different hydrogen transportation(Second)
 float onsitEmiHydTranCH4_2[hydForm] =...;
 
 //the amount of on-site CH4 emissions for different fueling station
 float onsitEmiFueStaCH4[hydForm] =...;
 
 // the amount of upstream N2O emissions for different feedstock and utility
 float upsEmiN2O[feedUti] =...;
 
 //the amount of on-site CH4 emissions for different production technology
 float onsitEmiProdTechN2O[prodTech] =...;
 
 //the amount of on-site CH4 emissions for different hydrogen terminal
 float onsitEmiHydTerN2O[hydForm] =...;
 
 //the amount of on-site CH4 emissions for different hydrogen transportation (first)
// float onsitEmiHydTranN2O_1[tranHyd1] =...;
 
  //the amount of on-site CH4 emissions for different hydrogen transportation (Second)
 float onsitEmiHydTranN2O_2[hydForm] =...;
 
 //the amount of on-site CH4 emissions for different fueling station
 float onsitEmiFueStaN2O[hydForm] =...;
 
 //the amounts of feedstock utility requirement for different hydrogen transportation (first)
// float feedReqHydTran_1[tranHyd1][feedUti] =...;
 
 //the amounts of feedstock utility requirement for different hydrogen transportation (Second)
 float feedReqHydTran_2[hydForm][feedUti] =...;
 
 // feedstock unit cost, $/unit
 float feedCost[feedType] = ...; 

 // operating cost of a feedstock supply site, $/d
// float feedOpeCost[feedType] = ...;
 
 // capital cost of a CCS (carbon capture and storage) site, $
 int  ccsCapCost = ...;  
                       
// operating cost of CO2 processing, $/kg
 float  co2OpeCost = ...; 
 
 // upper and lower limit of CO2 pipeline transport capacity, kg/d
 int co2TranCapaMax = ...;
 int co2TranCapaMin = ...;
 
 // capital cost of CO2 pipeline (unit length), $/km
 int co2PipCapCost = ...; 
 
 // production emission capture efficiency
 float prodEmiCapEff[prodTech][hydForm][prodSize] = ...;
 
  // upper and lower limit of CO2 processing capacity, kg/d
 int  co2ProcCapaMax[node] = ...;
 int  co2ProcCapaMin[node] = ...; 	
 
  // capital cost of H2 transportation pipeline (unit length), $/km (first)
// int h2PipCapCost1[tranHyd1] = ...;
 
   // capital cost of H2 transportation pipeline (unit length), $/km (Second)
 int h2PipCapCost2[hydForm] = ...;
 
 // upper and lower limit of H2 pipeline transport capacity, kg/d
 int h2TranCapaPipMax = ...;
 int h2TranCapaPipMin = ...;
 
 // **1 if there is a standard fueling station at this node in the time period t [new built]
 //int isFuelStandNew[node][timePeriod]= ...;

// **The number of production plant at this node
 int isProTime[node]= ...;
 
// **The number of production plant at this node in the time period t
 dvar int isPro[node][timePeriod];
 
 // **1 if there is a standard fueling station at this node in the time period t
 int isFuelStand[node][timePeriod]= ...;
 
 // **the number of existing production plants 
 int numProdT0[node][prodTech][hydForm][prodSize]= ...;
 
 // **the number of existing storage center 
 int numTerT0[node][hydForm][prodSize]= ...;
 
 // **the storage rate of existing storage center 
 int terRateFinT0[node][hydForm][prodSize]= ...;
 
 // **the number of existing stander fueling station 
 int numFuelStandT0[node][standFuelTech][hydForm][fuelSize]= ...;
 
 // **the number of existing onsite station 
 int numFuelOnsiteT0[node][onsiteFuelTech][onsiteFuelSize]= ...;
 
 // **the number of existing co2 storage site 
 int isCO2StoResT0[node]= ...;
 
 // **1 if there existing hydrogen pipeline transportation 1
// int isH2Tranpip1T0[tranHyd1][node][node] = ...;
 
 // **1 if there existing hydrogen pipeline transportation 2
  int isH2Tranpip2T0[hydForm][node][node] = ...;
 
 // PV: present value
  float PV [timePeriod] = ...;

 // replacement factor for production plants 
  float PVP[prodTech][hydForm][prodSize][timePeriod]= ...;
  
  // replacement factor for storage sites 
  float PVS[hydForm][prodSize][timePeriod]= ...;
  
   // replacement factor for off-site fueling station 
  float PVF[standFuelTech][hydForm][fuelSize][timePeriod]= ...; 
  
  // replacement factor for on-site fueling station 
  float PVOF[onsiteFuelTech][onsiteFuelSize][timePeriod]= ...;
  
  // replacement factor for CO2 storage site 
  float PVR[timePeriod]= ...;
  
  // replacement factor for vehicle transporation (first)
//  float PVTV1 [tranHyd1][timePeriod]= ...;
  
  // replacement factor for vehicle transporation (Second)
  float PVTV2 [hydForm][timePeriod]= ...;
  
  // replacement factor for hydrogen pipeline transporation 
//  float PVPH [timePeriod]= ...;
  
  // replacement factor for CO2 pipeline transporation 
  float PVPC [timePeriod]= ...;
                         
 //************************************************************************************************************************
 //// variables 
 
 // feedstock supply rate at node n
 dvar float+ prodFeedSupRate[node][feedType][timePeriod];
 
 // feedstock supply rate (for off-site production) at node n
 dvar float+ offFeedSupRate[node][feedType][timePeriod];
 
 // feedstock supply rate (for onsite fueling station) at node n																		   
 dvar float+ onsiteFeedSupRate[node][feedType][timePeriod]; 
 
 // production rate of a production plant at node n
 dvar float+ prodRate[node][prodTech][hydForm][prodSize][timePeriod]; 
 
 // operation storage rate of a terminal station at node n
 dvar float+ terRate[node][hydForm][prodSize][timePeriod];
 
 // storage rate of a terminal station at node n
 dvar float+ terRateFin[node][hydForm][prodSize][timePeriod];
 
 // fueling rate of a standard fueling station at node n
 dvar float+ standFuelRate[node][standFuelTech][hydForm][fuelSize][timePeriod]; 														  							
 
 // hydrogen transportation flux between two nodes (first)
// dvar float+ hydTranFlux1[tranHyd1][node][node][timePeriod];
 
 // hydrogen transportation flux between two nodes (second)
 dvar float+ hydTranFlux2[hydForm][node][node][timePeriod];
 
 // hydrogen transportation flux directly
 //dvar float+ hydTranFluxDir[tranHyd1][node][node][timePeriod];
 
 // number of transport vehicles (hydrogen)(integer) first transportation													
// dvar int numHydTranVehI1[tranHyd1][timePeriod];
 
 // number of transport vehicles (hydrogen)(integer) second transportation													
 dvar int numHydTranVehI2[hydForm][timePeriod];
 
 // number of transport vehicles (hydrogen)(integer) directly													
 //dvar int numHydTranVehIDir[tranHyd1][timePeriod];
									 									 
 // 1 if the node is chosen as a feedstock supplier of production sites (feedType e)
 dvar boolean isFeed[node][feedType][timePeriod];
 
 // 1 if the node is chosen as a feedstock supplier of production sites
 dvar boolean isFeedType[node][timePeriod];

 // 1 if there is a production plant (prodTech p, hydForm i, prodSize j) at this node
// dvar boolean isProd[node][prodTech][hydForm][prodSize][timePeriod];
 
  // number of production plant (prodTech p, hydForm i, prodSize j) at this node
 dvar int numProd[node][prodTech][hydForm][prodSize][timePeriod];

 // 1 if there is a production plant (prodTech p, hydForm i, prodSize j) at this node [new built]
 //dvar boolean isProdNew[node][prodTech][hydForm][prodSize][timePeriod];
 
 // number of production plant (prodTech p, hydForm i, prodSize j) at this node [new built]
 dvar int numProdNew[node][prodTech][hydForm][prodSize][timePeriod];
 
 // 1 if there is a production plant at this node
// dvar boolean isProdTechFormSize[node][timePeriod];	
 
 // number of production plant at this node
 dvar int numProdTechFormSize[node][timePeriod];																		   

 // 1 if there is a standard fueling station (standFuelTech fs, hydForm i, fuelSize j) at this node
// dvar boolean isFuel[node][standFuelTech][hydForm][fuelSize][timePeriod];

 // number of standard fueling station (standFuelTech fs, hydForm i, fuelSize j) at this node
 dvar int numFuelStand[node][standFuelTech][hydForm][fuelSize][timePeriod];
 
// // 1 if there is a standard fueling station (standFuelTech fs, hydForm i, fuelSize j) at this node [new built]
// dvar boolean isFuelNew[node][standFuelTech][hydForm][fuelSize][timePeriod];
 
  // number of standard fueling station (standFuelTech fs, hydForm i, fuelSize j) at this node [new built]
 dvar int numFuelStandNew[node][standFuelTech][hydForm][fuelSize][timePeriod];
 
 // 1 if there is a fueling station at this node
 //dvar boolean isFuelTechFormSize[node][timePeriod];																	 
 
 // 1 if hydrogen is to be transported from node n to m in mode lh (first transportation)
// dvar boolean isHydTran1[tranHyd1][node][node][timePeriod];
 
 // 1 if hydrogen is to be transported from node n to m in mode lh (second transportation)
 dvar boolean isHydTran2[hydForm][node][node][timePeriod];
 
 // 1 if hydrogen is to be transported from node n to m in mode lh (directly transportation)
// dvar boolean isHydTranDir[tranHyd1][node][node][timePeriod];
 
 // 1 if hydrogen is output in the node n  (directly transportation)
// dvar boolean isHydTranDirnode[tranHyd1][node][timePeriod];
 
 // 1 if hydroen fueling demand flow pair q is captured
 //dvar boolean isCaptured[pair]; 
 
 // 1 if there is a terminal station (hydForm i) at this node
 //dvar boolean isTer[node][hydForm][stoSize][timePeriod];
 
 //number of terminal station (hydForm i) at this node
 dvar int numTer[node][hydForm][prodSize][timePeriod];
 
  // 1 if there is a terminal station (hydForm i) at this node in the time period t [new built]
 //dvar boolean isTerNew[node][hydForm][stoSize][timePeriod];
 
  // number of terminal station (hydForm i) at this node in the time period t [new built]
 dvar int numTerNew[node][hydForm][prodSize][timePeriod];
 
 // 1 if there is a terminal station at this node
// dvar boolean isTerFormSize[node][timePeriod];
 
 // number of terminal station at this node
 //dvar int numTerFormSize[node][timePeriod];
 
 // number of onsite fueling station (onsiteFuelTech fo, fuelSize j) at this node
 dvar int numFuelOnsite[node][onsiteFuelTech][onsiteFuelSize][timePeriod];
 
  // number of onsite fueling station (onsiteFuelTech fo, fuelSize j) at this node [new built]
 dvar int numFuelOnsiteNew[node][onsiteFuelTech][onsiteFuelSize][timePeriod];
 
  // number of onsite fueling station (onsiteFuelTech fo) at this node in the time period t
 dvar int numFuelOnsiteSize[node][onsiteFuelTech][timePeriod]; 
 
 // number of onsite fueling station at this node
 dvar int numFuelOnsiteTechSize[node][timePeriod];
 
  // the number of onsite fueling stations [new built]
 dexpr int numFuelOnsiteNode[fo in onsiteFuelTech][j in onsiteFuelSize][t in timePeriod] = sum(n in node) numFuelOnsiteNew[n][fo][j][t];
 
// fueling rate of a onsite fueling station at node n
 dvar float+ onsiteFuelRate[node][onsiteFuelTech][onsiteFuelSize][timePeriod];  
 
 // the total fueling rate of onsite fueling stations (onsiteFuelTech fo, fuelSize j)
 dexpr float onsiteFuelRateTot[fo in onsiteFuelTech][j in onsiteFuelSize][t in timePeriod] = sum(n in node) onsiteFuelRate[n][fo][j][t];
 
 // the total fueling rate of onsite fueling stations (onsiteFuelTech)
 //dexpr float onsiteFuelRateTechTot[fo in onsiteFuelTech]= sum(n in node,j in fuelSize) onsiteFuelRate[n][fo][j];
 
 // 1 if there is a CO2 storage reservoir at this node
 dvar boolean isCO2StoRes[node][timePeriod];	
 
 // 1 if there is a CO2 storage reservoir at this node [new built]
 dvar boolean isCO2StoResNew[node][timePeriod];
 
 // CO2 processing rate of a CCS site at node n
 dvar float+ co2ProcRate[node][timePeriod];	
															  
 // 1 if the emission of production plant at node n is processed
 dvar boolean isProdEmiProc[node][timePeriod];
 
 // 1 if CO2 is to be transported from node n to m
 dvar boolean isCO2Tran[node][node][timePeriod]; 
 
 // 1 if CO2 is to be transported from node n to m [new built]
 dvar boolean isCO2TranNew[node][node][timePeriod]; 
 
 // 1 if H2 is to be transported from node n to m (first)
// dvar boolean isH2Tranpip1[tranHyd1][node][node][timePeriod]; 
 
 // 1 if H2 is to be transported from node n to m (first) [new built]
// dvar boolean isH2Tranpip1New[tranHyd1][node][node][timePeriod]; 

 // 1 if H2 is to be transported from node n to m (second)
 dvar boolean isH2Tranpip2[hydForm][node][node][timePeriod];
 
 // 1 if H2 is to be transported from node n to m (second) [new built]
 dvar boolean isH2Tranpip2New[hydForm][node][node][timePeriod];
 
 // CO2 transportation flux between two nodes
 dvar float+ co2TranFlux[node][node][timePeriod];
 
 // H2 transportation flux between two nodes (first)
// dvar float+ h2TranFluxPip1[tranHyd1][node][node][timePeriod];
 
 // H2 transportation flux between two nodes (second)
 dvar float+ h2TranFluxPip2[hydForm][node][node][timePeriod];
 
 // feedstock transportation flux between two nodes
 dvar float+ feedTranFlux[tranFeed][node][node][timePeriod];
 
 // number of transport vehicles (feedstock)(integer) 
 dvar int numFeedTranVehI[tranFeed][timePeriod];
 
  // production rate of a production plant of which emission be processed
 dvar float+ prodRateEmiProc[node][prodTech][hydForm][prodSize][timePeriod]; 
 
 // Emission cost	
 // dvar float EMC; 

 //************************************************************************************************************************ 
 //// expressions 
 
  // the number of terminal stations ( hydForm i)
 //dexpr int numstr[i in hydForm][s in stoSize][t in timePeriod] = sum (n in node) isTerNew[n][i][s][t];
//   dexpr int numstr = sum (m in node) isTer[m];

 //-- the number of production plants (proTech p, hydForm i, prodSize j)
 //dexpr int numProd[p in prodTech][i in hydForm][j in prodSize][t in timePeriod] = sum(n in node) isProdNew[n][p][i][j][t];
 
 // the number of standard fueling stations (standFuelTech fs, hydForm i, fuelSize j)
 dexpr int numFuelStandNode[fs in standFuelTech][i in hydForm][j in fuelSize][t in timePeriod] = sum(n in node) numFuelStandNew[n][fs][i][j][t];
 
 // the total production rate of production plants (proTech p, hydForm i, prodSize j)
 dexpr float prodRateTot[p in prodTech][i in hydForm][j in prodSize][t in timePeriod] = sum(n in node) prodRate[n][p][i][j][t];
 
 // the storage rate of form i hydrogen in node n 
 dexpr float terRateSize[n in node][i in hydForm][t in timePeriod] = sum (s in prodSize)terRate[n][i][s][t];
  
 // the storage rate of form i hydrogen in size z storage site 
 dexpr float terRateNode[i in hydForm][s in prodSize][t in timePeriod] = sum ( n in node)terRate[n][i][s][t];
  
 // the total fueling rate of standard fueling stations (standFuelTech fs, hydForm i, fuelSize j)
 dexpr float standFuelRateNode[fs in standFuelTech][i in hydForm][j in fuelSize][t in timePeriod] = sum(n in node) standFuelRate[n][fs][i][j][t];	
 
 // the total daily hydrogen fueling demand
 //dexpr float hydFuelDem[n in node, t in timePeriod] = hydFuelDemFlowNode[n][t] * PE[t];

 dexpr float hydFuelDemNode[t in timePeriod] = sum(n in node)hydFuelDem[n][t];
 
 //dexpr float hydFuelDemTime[n in node] = sum(t in timePeriod) hydFuelDemFlowNode[n] * PE[t];
 
 dexpr float hydFuelDemTot = sum(t in timePeriod) hydFuelDemNode[t];
 
 //The hydrogen production rate in total (including onsite)
 dexpr float hydFuelProdTot[t in timePeriod] = sum (p in prodTech, i in hydForm, j in prodSize)prodRateTot[p][i][j][t] 
 												+ sum(fo in onsiteFuelTech, j in onsiteFuelSize)onsiteFuelRateTot[fo][j][t];
 
 // The cost in the process of production $/kg
//dexpr float prodCost =  (sum (p in prodTech, i in hydForm, j in prodSize, t in timePeriod) prodCapCost[p][i][j][t] * numProd[p][i][j][t] 
//							+  sum (p in prodTech, i in hydForm, j in prodSize) prodCapCost[p][i][j][t] * PVP[p][i][j][t] * numProd[p][i][j][t] 
// 						  + sum (n in node, p in prodTech, i in hydForm, j in prodSize) prodOpeCost[p][i][j] * prodRateTot[n][p][i][j][t]* opePeriod)
// 						  + sum(n in node, fo in onsiteFuelTech, j in onsiteFuelSize) (onsiteFuelCapCost[fo][j] * (1 +  PVOF[fo][j][t]) 
// 						    * numOnsiteFuel[fo][j][t]  + onsiteFuelOpeCost[fo][j] * onsiteFuelRateTot[n][fo][j][t] * opePeriod ) ;
//  // The cost in the process of production $/kg

dexpr float prodCostTime[t in timePeriod] = PV[t] * (sum (n in node, p in prodTech, i in hydForm, j in prodSize) (prodCapCost[p][i][j] * numProdNew[n][p][i][j][t]) 
						  + sum (n in node, p in prodTech, i in hydForm, j in prodSize) prodCapCost[p][i][j] * PVP[p][i][j][t] * numProdNew[n][p][i][j][t] 
 						  + sum (n in node, p in prodTech, i in hydForm, j in prodSize) prodOpeCost[p][i][j] * prodRate[n][p][i][j][t]* opePeriod
 						  + sum( fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelCapCost[fo][j] * numFuelOnsiteNode[fo][j][t]
 						  + sum( fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelCapCost[fo][j] * PVOF[fo][j][t] * numFuelOnsiteNode[fo][j][t]
 						  + sum(n in node, fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelOpeCost[fo][j] * onsiteFuelRate[n][fo][j][t] * opePeriod ) ;
 						  
dexpr float prodCost = sum (t in timePeriod) PV[t] * (sum (n in node, p in prodTech, i in hydForm, j in prodSize) (prodCapCost[p][i][j] * numProdNew[n][p][i][j][t]) 
						  + sum (n in node, p in prodTech, i in hydForm, j in prodSize) prodCapCost[p][i][j] * PVP[p][i][j][t] * numProdNew[n][p][i][j][t] 
 						  + sum (n in node, p in prodTech, i in hydForm, j in prodSize) prodOpeCost[p][i][j] * prodRate[n][p][i][j][t]* opePeriod
 						  + sum( fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelCapCost[fo][j] * numFuelOnsiteNode[fo][j][t]
 						  + sum( fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelCapCost[fo][j] * PVOF[fo][j][t] * numFuelOnsiteNode[fo][j][t]
 						  + sum(n in node, fo in onsiteFuelTech, j in onsiteFuelSize) onsiteFuelOpeCost[fo][j] * onsiteFuelRate[n][fo][j][t] * opePeriod ) ;						    
 
 // The cost in the process of storage $/kg 
 dexpr float strCost = sum (t in timePeriod) PV[t] * (sum (n in node, i in hydForm,s in prodSize) strCapCost[i][s] * numTerNew[n][i][s][t]
 						+ sum (n in node, i in hydForm,s in prodSize) strCapCost[i][s] * PVS[i][s][t] * numTerNew[n][i][s][t]
 						+ sum (i in hydForm,s in prodSize) strOpeCost[i][s] * terRateNode[i][s][t] * opePeriod);
 
 dexpr float strCostTime[t in timePeriod] =  PV[t] * (sum (n in node, i in hydForm,s in prodSize) strCapCost[i][s] * numTerNew[n][i][s][t]
 						+ sum (n in node, i in hydForm,s in prodSize) strCapCost[i][s] * PVS[i][s][t] * numTerNew[n][i][s][t]
 						+ sum (i in hydForm,s in prodSize) strOpeCost[i][s] * terRateNode[i][s][t] * opePeriod);
 						 
 //**************************************************
 // transportation fuel cost (hydrogen first transportation) 
// dexpr float hydTranFuelCost1 [t in timePeriod]  = sum(lh1 in tranHyd1, n in node, m in node) 
// 					lh1.fuelPrice * (2 * distOD[n][m] * hydTranFlux1[lh1][n][m][t] / (lh1.fuelEco * lh1.tranCap));
 
// transportation fuel cost (hydrogen second transportation ) 
 dexpr float hydTranFuelCost2[t in timePeriod]  = sum(i in hydForm, m in node, n in node) 
 					fuelPrice * (2 * distOD[m][n] * hydTranFlux2[i][n][m][t]/ (fuelEco * tranCap[i]));				

// transportation fuel cost (directly ) 
// dexpr float hydTranFuelCost3[t in timePeriod]  = sum(lh1 in tranHyd1, m in node, n in node) 
// 					lh1.fuelPrice * (2 * distOD[m][n] * hydTranFluxDir[lh1][n][m][t]/ (lh1.fuelEco * lh1.tranCap));
 					
 // transportation fuel cost (feedstock)
 dexpr float feedTranFuelCost[t in timePeriod]  = sum(le in tranFeed, n in node, m in node) 
 					le.fuelPrice * (2 * distOD[n][m] * feedTranFlux[le][n][m][t] / (le.fuelEco * le.tranCap));

 // transportation labor cost ((hydrogen first transportation)
// dexpr float hydTranLabCost1 [t in timePeriod]  = sum(lh1 in tranHyd1, n in node, m in node) 
// 					lh1.driverWage * (hydTranFlux1[lh1][n][m][t] * ((2 * distOD[n][m] / lh1.speed) + lh1.loUnloTime) / lh1.tranCap);
 					
 // transportation labor cost ((hydrogen second transportation)
 dexpr float hydTranLabCost2 [t in timePeriod]  = sum(i in hydForm, m in node, n in node) 
 					driverWage * (hydTranFlux2[i][n][m][t] * ((2 * distOD[m][n] / speed) + loUnloTime) / tranCap[i]);
 
 // transportation labor cost (directly)
// dexpr float hydTranLabCost3 [t in timePeriod]  = sum(lh1 in tranHyd1, m in node, n in node) 
// 					lh1.driverWage * (hydTranFluxDir[lh1][n][m][t] * ((2 * distOD[m][n] / lh1.speed) + lh1.loUnloTime) / lh1.tranCap);					

 // transportation labor cost (feedstock)
 dexpr float feedTranLabCost[t in timePeriod]  = sum(le in tranFeed, n in node, m in node) 
 					le.driverWage * (feedTranFlux[le][n][m][t] * ((2 * distOD[n][m] / le.speed) + le.loUnloTime) / le.tranCap);

 // transportation maintenance cost (hydrogen first transportation)
// dexpr float hydTranMaintCost1 [t in timePeriod]  = sum(lh1 in tranHyd1, n in node, m in node) 
// 					lh1.maintEx * (2 * distOD[n][m] * hydTranFlux1[lh1][n][m][t] / lh1.tranCap); 

 // transportation maintenance cost ((hydrogen second transportation)
 dexpr float hydTranMaintCost2 [t in timePeriod]  = sum(i in hydForm, m in node, n in node) 
 					maintEx * (2 * distOD[m][n] * hydTranFlux2[i][n][m][t] / tranCap[i]); 
 
 // transportation maintenance cost (directly)
// dexpr float hydTranMaintCost3 [t in timePeriod]  = sum(lh1 in tranHyd1, m in node, n in node) 
// 					lh1.maintEx * (2 * distOD[m][n] * hydTranFluxDir[lh1][n][m][t] / lh1.tranCap);
 										
 // transportation maintenance cost (feedstock)
 dexpr float feedTranMaintCost[t in timePeriod]  = sum(le in tranFeed, n in node, m in node) 
 					le.maintEx * (2 * distOD[n][m] * feedTranFlux[le][n][m][t] / le.tranCap); 

 // transportation general cost (hydrogen first transportation)
// dexpr float hydTranGenCost1[t in timePeriod]  = sum(lh1 in tranHyd1, n in node, m in node) 
// 					lh1.genEx * hydTranFlux1[lh1][n][m][t] * (((2 * distOD[n][m] / lh1.speed) 
// 					+ lh1.loUnloTime) / (lh1.tranAva * lh1.tranCap));	

// transportation general cost (hydrogen second transportation)
 dexpr float hydTranGenCost2[t in timePeriod]  = sum(i in hydForm, m in node, n in node) 
 					genEx * hydTranFlux2[i][n][m][t] * (((2 * distOD[m][n] / speed) 
 					+ loUnloTime) / (tranAva * tranCap[i]));	
 
 // transportation general cost (directly)
// dexpr float hydTranGenCost3[t in timePeriod]  = sum(lh1 in tranHyd1, m in node, n in node) 
// 					lh1.genEx * hydTranFluxDir[lh1][n][m][t] * (((2 * distOD[m][n] / lh1.speed) 
// 					+ lh1.loUnloTime) / (lh1.tranAva * lh1.tranCap));	
 										
 // transportation general cost (feedstock)
 dexpr float feedTranGenCost[t in timePeriod]  = sum(le in tranFeed, n in node, m in node) 
 					le.genEx * feedTranFlux[le][n][m][t] * (((2 * distOD[n][m] / le.speed) 
 					+ le.loUnloTime) / (le.tranAva * le.tranCap));
 					
 // transportation vehicle rent cost (feedstock)
 dexpr float feedTranRentCost[t in timePeriod] = sum(le in tranFeed) le.vehRentCost * numFeedTranVehI[le][t];									
 
 // transportation operating cost (hydrogen first transportation)
// dexpr float hydTranOpeCost1 = sum (t in timePeriod) (hydTranFuelCost1[t] + hydTranLabCost1[t] + hydTranMaintCost1[t] + hydTranGenCost1[t]);
 
 // transportation operating cost (hydrogen second transportation)
 dexpr float hydTranOpeCost2 = sum (t in timePeriod) (hydTranFuelCost2[t] + hydTranLabCost2[t] + hydTranMaintCost2[t] + hydTranGenCost2[t]);
 
 // transportation operating cost (hydrogen directly transportation)
// dexpr float hydTranOpeCost3 = sum (t in timePeriod) (hydTranFuelCost3[t] + hydTranLabCost3[t] + hydTranMaintCost3[t] + hydTranGenCost3[t]);
 
 // transportation operating cost (feedstock)
 dexpr float feedTranOpeCost = sum (t in timePeriod) (feedTranFuelCost[t] + feedTranLabCost[t] + feedTranMaintCost[t] + feedTranGenCost[t] + feedTranRentCost[t]);
 
 // the total length of CO2 pipeline
 dexpr float co2TranPipLen[t in timePeriod] = sum(n in node, m in node) isCO2TranNew[n][m][t] * distOD[n][m];
 
 // transportation capital cost(CO2)
 dexpr float co2TranCapCost = sum (t in timePeriod) PV[t] * co2PipCapCost * co2TranPipLen[t];
 
  // the total length of H2 pipeline (H2 first)
// dexpr float h2TranPipLen1[lh1 in tranHyd1][t in timePeriod] = sum(n in node, m in node) isH2Tranpip1New[lh1][n][m][t] * distOD[n][m];
// 
// dexpr float h2TranPip1[lh1 in tranHyd1][n in node][m in node][t in timePeriod] = isH2Tranpip1[lh1][n][m][t] * distOD[n][m];
 
 // transportation capital cost (H2 first)
// dexpr float h2TranCapCostPip1 = sum (t in timePeriod, lh1 in tranHyd1) PV[t] * h2PipCapCost1[lh1] * h2TranPipLen1[lh1][t];
 
  // the total length of H2 pipeline (H2 second)
 dexpr float h2TranPipLen2[i in hydForm][t in timePeriod] = sum( n in node, m in node) isH2Tranpip2New[i][n][m][t] * distOD[n][m];
 
 dexpr float h2TranPipFormLen2[i in hydForm][n in node][m in node][t in timePeriod] =  isH2Tranpip2New[i][n][m][t] * distOD[n][m];
  
 // transportation capital cost (H2 second)
 dexpr float h2TranCapCostPip2 = sum (t in timePeriod, i in hydForm) PV[t] * h2PipCapCost2[i] * h2TranPipLen2[i][t];	
 
 // The cost in the process of transportation $/kg
 dexpr float tranCostTime[t in timePeriod] =  PV[t] *( sum (i in hydForm)(vehPurCost[i]* numHydTranVehI2[i][t] + vehPurCost[i]* PVTV2[i][t]* numHydTranVehI2[i][t])
  							 + hydTranOpeCost2 + feedTranOpeCost+ co2TranCapCost  +  h2TranCapCostPip2);  
  							
 dexpr float tranCost = sum (t in timePeriod) PV[t] *( sum (i in hydForm)(vehPurCost[i]* numHydTranVehI2[i][t] + vehPurCost[i]* PVTV2[i][t]* numHydTranVehI2[i][t])
  							 + hydTranOpeCost2  + feedTranOpeCost+ co2TranCapCost  +  h2TranCapCostPip2);                                		
 
 //********************************************************************
 // The cost in the process of fueling station $/kg 	
dexpr float fuCostTime[t in timePeriod] =  PV[t] * (sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelCapCost[fs][i][j] * numFuelStandNode[fs][i][j][t]
 							+ sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelCapCost[fs][i][j] * PVF[fs][i][j][t] * numFuelStandNode[fs][i][j][t])
 							+ sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelOpeCost[fs][i][j] * standFuelRateNode[fs][i][j][t] * opePeriod;
 																					
 dexpr float fuCost = sum (t in timePeriod) (PV[t] * (sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelCapCost[fs][i][j] * numFuelStandNode[fs][i][j][t]
 							+ sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelCapCost[fs][i][j] * PVF[fs][i][j][t] * numFuelStandNode[fs][i][j][t])
 							+ sum (fs in standFuelTech, i in hydForm, j in fuelSize) standFuelOpeCost[fs][i][j] * standFuelRateNode[fs][i][j][t] * opePeriod);

//********************************************************************************
  // the production rate of production plants for anysize
 dexpr float proRatSize[ n in node, p in prodTech,i in hydForm, t in timePeriod] = sum(  j in prodSize) prodRate[n][p][i][j][t];
 
 // the production rate of production plants using proTech p at node n
 dexpr float proRatFormSize[ n in node, p in prodTech, t in timePeriod] = sum( i in hydForm, j in prodSize) prodRate[n][p][i][j][t];
 
 // the total fueling rate of onsite fueling stations (onsiteFuelTech) at node n
 dexpr float onsiteFuelRateSize[n in node, fo in onsiteFuelTech, t in timePeriod]= sum(j in onsiteFuelSize) onsiteFuelRate[n][fo][j][t];
 
 // the production rate of production plants form i at node n
 dexpr float proRatTechSize[  n in node, i in hydForm, t in timePeriod] = sum( p in prodTech, j in prodSize) prodRate[n][p][i][j][t];
 
 // the emission rate of a production plant at node n of which emission can be processed
 dexpr float prodEmiRateProc[n in node][t in timePeriod] = sum(p in prodTech, i in hydForm, j in prodSize, fu in feedUti) prodRateEmiProc[n][p][i][j][t] * prodEmiCapEff[p][i][j] * feedReqProdTech[p][i][fu] * upsEmiCO2[fu];	
 
 //CO2 emission in the process of hydrogen production
 dexpr float emiProCO2[ n in node, t in timePeriod] = sum(i in hydForm, p in prodTech, fu in feedUti) proRatSize[n][p][i][t] * feedReqProdTech[p][i][fu] * upsEmiCO2[fu] 
                      + sum( p in prodTech) proRatFormSize[n][p][t] * onsitEmiProdTechCO2[p] 
                      + sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFulTech[fo][fu] * upsEmiCO2[fu]
                      - prodEmiRateProc[n][t];
 
 //CO2 emission in the process of hydrogen storage
 dexpr float emiStrCO2[n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti)terRateSize[n][i][t] * feedReqHydTer[i][fu] * upsEmiCO2[fu] 
                      + sum(i in hydForm) terRateSize[n][i][t] * onsitEmiHydTerCO2[i];
 
 //CO2 emission in the process of hydrogen transportation 
  dexpr float emiTranCO2[n in node, t in timePeriod] =  sum( m in node, fu in feedUti,i in hydForm) 2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * feedReqHydTran_2[i][fu] * upsEmiCO2[fu]
                    + sum( m in node,i in hydForm) 2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * onsitEmiHydTranCO2_2[i] ;                            
                                           
 //CO2 emission in the process of hydrogen fueling station
 dexpr float emiFueCO2 [n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti) proRatTechSize[n][i][t] * feedReqFueSta[i][fu] * upsEmiCO2[fu]
 			+sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFueSta[fo][fu]* upsEmiCO2[fu];    
 
 // the amount of CO2 emission////////////////////////////////////
 dexpr float emiCO2node [t in timePeriod]  = sum (n in node) (emiProCO2[n][t]  + emiStrCO2[n][t] + emiTranCO2[n][t] + emiFueCO2[n][t]); 
 
// dexpr float emiCO2 = sum(t in timePeriod) emiCO2node[t] * opePeriod; 
 
 //CH4 emission in the process of hydrogen production
 dexpr float emiProCH4[n in node, t in timePeriod] = sum(i in hydForm,p in prodTech, fu in feedUti) proRatSize[n][p][i][t] * feedReqProdTech[p][i][fu] * upsEmiCH4[fu] 
                      + sum( p in prodTech) proRatFormSize[n][p][t] * onsitEmiProdTechCH4[p]
                      + sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFulTech[fo][fu] * upsEmiCH4[fu];
                      //- prodEmiRateProc[n];
  
 //CH4 emission in the process of hydrogen storage
 dexpr float emiStrCH4[n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti) terRateSize[n][i][t] * feedReqHydTer[i][fu] * upsEmiCH4[fu] 
                      + sum(i in hydForm) terRateSize[n][i][t] * onsitEmiHydTerCH4[i];
 
 //CH4 emission in the process of hydrogen transportation
 dexpr float emiTranCH4[n in node, t in timePeriod] =  sum( m in node, fu in feedUti, i in hydForm) 2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * feedReqHydTran_2[i][fu] * upsEmiCH4[fu]
                    + sum(m in node,i in hydForm) 2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * onsitEmiHydTranCH4_2[i];
                                                           
 //CH4 emission in the process of hydrogen fueling station
 dexpr float emiFueCH4[n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti) proRatTechSize[n][i][t] * feedReqFueSta[i][fu] * upsEmiCH4[fu]
 						+ sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFueSta[fo][fu]* upsEmiCH4[fu];    
 
 // the amount of CH4 emission////////////////////////////////////
 dexpr float emiCH4node [t in timePeriod] = sum (n in node) (emiProCH4 [n][t] + emiStrCH4 [n][t] + emiTranCH4 [n][t] + emiFueCH4 [n][t]);
 
 //TranCH4[n] + emiFueCH4[n];
 
 //dexpr float emiCH4 = sum(t in timePeriod) emiCH4node [t] * opePeriod;

 //N2O emission in the process of hydrogen production
 dexpr float emiProN2O[n in node, t in timePeriod] = sum(i in hydForm, p in prodTech, fu in feedUti) proRatSize[n][p][i][t] * feedReqProdTech[p][i][fu] * upsEmiN2O[fu] 
                      + sum( p in prodTech) proRatFormSize[n][p][t] * onsitEmiProdTechN2O[p]
                      + sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFulTech[fo][fu] * upsEmiN2O[fu];
                      //- prodEmiRateProc[n];
 //N2O emission in the process of hydrogen storage
 dexpr float emiStrN2O[n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti) terRateSize[n][i][t] * feedReqHydTer[i][fu] * upsEmiN2O[fu] 
                      + sum(i in hydForm)terRateSize[n][i][t] * onsitEmiHydTerN2O[i];
 
 //N2O emission in the process of hydrogen transportation
 dexpr float emiTranN2O[n in node, t in timePeriod] =  sum(  m in node, fu in feedUti,i in hydForm)2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * feedReqHydTran_2[i][fu] * upsEmiN2O[fu]
                    + sum( m in node,i in hydForm)2 * hydTranFlux2[i][n][m][t] * distOD[n][m] * onsitEmiHydTranN2O_2[i];
 
 //N2O emission in the process of hydrogen fueling station
 dexpr float emiFueN2O[n in node, t in timePeriod] = sum(i in hydForm, fu in feedUti) proRatTechSize[n][i][t] * feedReqFueSta[i][fu] * upsEmiN2O[fu]
 						+ sum(fo in onsiteFuelTech, fu in feedUti)  onsiteFuelRateSize[n][fo][t] * feedReqOnsiteFueSta[fo][fu]* upsEmiN2O[fu];    
 
 // the amount of N2O emission////////////////////////////////////
 dexpr float emiN2Onode[t in timePeriod] = sum (n in node) (emiProN2O[n][t] + emiStrN2O[n][t] + emiTranN2O[n][t] + emiFueN2O[n][t]);
 
// dexpr float emiN2O = sum(t in timePeriod) emiN2Onode[t] * opePeriod;

 // total global warming potentials factor////////////////////////////////////////////////////////////////////////////////////
 dexpr float gloWarmPotFacnode [t in timePeriod] = emiCO2node[t] + 28 * emiCH4node[t] + 265* emiN2Onode[t];
 
 dexpr float prodEmi[t in timePeriod] = sum(n in node)(emiProCO2[n][t] + 28 * emiProCH4 [n][t] + 265* emiProN2O[n][t])/hydFuelDemNode[t] ;
 dexpr float strEmi[t in timePeriod] = sum(n in node)(emiStrCO2[n][t] + 28 * emiStrCH4 [n][t] + 265* emiStrN2O[n][t])/hydFuelDemNode[t] ;
 dexpr float tranEmi[t in timePeriod] = sum(n in node)(emiTranCO2[n][t] + 28 * emiTranCH4[n][t] + 265* emiTranN2O[n][t])/hydFuelDemNode[t] ;
 dexpr float fuelEmi[t in timePeriod] = sum(n in node)(emiFueCO2[n][t] + 28 * emiFueCH4[n][t] + 265* emiFueN2O[n][t])/hydFuelDemNode[t] ;
 
 dexpr float gloWarmPotFac = sum(t in timePeriod)gloWarmPotFacnode[t];
 
 //dexpr float gloWarmPotFac_it =  sum(t in timePeriod)gloWarmPotFacnode[t] / hydFuelDemTot ;
 dexpr float gloWarmPotFac_it_Time[t in timePeriod] =  gloWarmPotFacnode[t] / hydFuelDemNode[t] ;
 //*******************************************************************************************
//  // the feedstock supply rate for onsite production
//  dexpr float onsiteFeedSupRate[n in node][e in feedType][t in timePeriod] = sum (j in onsiteFuelSize) onsiteFuelRate[n][e][j][t]* onsiteconverRate[e]; 
 
// the total feedstock supply rate
 dexpr float feedSupRate[e in feedType][t in timePeriod] =  sum(n in node) (offFeedSupRate[n][e][t] + onsiteFeedSupRate[n][e][t]); 
// dexpr float feedSupRate[e in feedType][t in timePeriod] =  sum(n in node) (prodFeedSupRate[n][e][t] + onsiteFeedSupRate[n][e][t]); 

 // the total feedstock buying cost
 dexpr float EC = sum(e in feedType,t in timePeriod ) feedSupRate[e][t] * feedCost[e] * opePeriod;
 dexpr float ECTime[t in timePeriod] = sum(e in feedType ) feedSupRate[e][t] * feedCost[e] * opePeriod; 
  
 // 1 if feedstock is to be transported from node n to m in mode lf
 dvar boolean isFeedTran[tranFeed][node][node][timePeriod];
 
 // the number of feedstock supply site(feedType e)
 //dexpr int numFeed[e in feedType] = sum(n in node) isFeedType[n][e];
 
 // The cost in the site of feedstock $/kg
 //dexpr float feCost = sum(e in feedType) (feedOpeCost[e] * numFeed[e]);
 
 // the total proccessing rate of CO2
 dexpr float co2ProcRateTot = sum(n in node,t in timePeriod) co2ProcRate[n][t]; 
 
 // the number of CO2 storage reservoirs
 dexpr int numCO2StoRes[t in timePeriod] = sum(n in node) isCO2StoResNew[n][t]; 
 
 // The cost in the site of co2 storage $/kg
 dexpr float co2storCost =   sum (t in timePeriod) PV[t] * ccsCapCost * numCO2StoRes[t] + co2OpeCost * co2ProcRateTot * opePeriod  ;
 dexpr float co2storCostTime[t in timePeriod] =   PV[t] * ccsCapCost * numCO2StoRes[t] + co2OpeCost * co2ProcRateTot * opePeriod  ;
// // The final storage rate in each period
// dexpr float terRateFin[n in node,i in hydForm, t in timePeriod] = sum(s in stoSize)terRate[n][i][s][t] + sum(m in node, lh in tranHyd: lh.hydForm == i) hydTranFlux2[lh][m][n][t] 
//    	    	+ sum(m in node, lh in tranHyd: lh.hydForm == i)h2TranFluxPip2[lh][m][n][t] + sum(m in node, lh in tranHyd: lh.hydForm == i) hydTranFluxDir[lh][m][n][t]
//    	    		- sum(m in node, lh in tranHyd: lh.hydForm == i) hydTranFlux2[lh][n][m][t] - sum(m in node, lh in tranHyd: lh.hydForm == i) h2TranFluxPip2[lh][n][m][t]
//    	    			- sum(fs in standFuelTech, j in fuelSize) standFuelRate[n][fs][i][j][t];
 
 // leverized cost of hydrogen supply chain////////////////////////////////////////////////////////////////////////////////////////////////
 dexpr float lcohTime[t in timePeriod] = ( prodCostTime[t] + strCostTime[t] + tranCostTime[t] + fuCostTime[t] + ECTime[t] + co2storCostTime[t]) / (hydFuelDemNode[t]* opePeriod);
 
 dexpr float lcoh =  ( prodCost + strCost + tranCost + fuCost + EC + co2storCost) / hydFuelDemTot ;
// dexpr float lcoh =  ( prodCost + strCost + tranCost + fuCost + EC + co2storCost) / (hydFuelDemTot * opePeriod);

 //************************************************************************************************************************
 //// objective
 
    minimize lcoh; 
 
//   minimize gloWarmPotFac;
 
  //************************************************************************************************************************
 //// constraints

subject to {
	//////////////////////////////demand//////////////////////////////	
	
	// the fueling rate at node n should cover the hydrogen fueling demand flow
   	constraint_01:
   		forall(n in node, t in timePeriod)
   		  	sum(fs in standFuelTech, i in hydForm, j in fuelSize) standFuelRate[n][fs][i][j][t] >= isFuelStand[n][t] * hydFuelDem[n][t];
   	  	
	constraint_1093:
		forall(t in timePeriod)
		    hydFuelDemNode[t] == sum(n in node, fs in standFuelTech, i in hydForm, j in fuelSize) standFuelRate[n][fs][i][j][t]
		    						+ sum(fo in onsiteFuelTech, j in onsiteFuelSize)onsiteFuelRateTot[fo][j][t];
		    						
   	///////////////////////////////feedstock//////////////////////////////  	
   	
   	// the relationships among feedstock binary variables 
   	constraint_02:
   		forall(n in node, t in timePeriod)
   		  	isFeedType[n][t] == sum(e in feedType) isFeed[n][e][t];
   	
   	// conservation of hydrogen (onsite) at each node
	constraint_147:
		forall(n in node, efo in feedOnsiteFuel, t in timePeriod)	
			onsiteFeedSupRate[n][efo.feedType][t] == sum (j in onsiteFuelSize) onsiteFuelRate[n][efo.onsiteFuelTech][j][t]* efo.converRate;
	
	// conservation of hydrogen (offsite) at each node
	constraint_148:
		forall(n in node, ep in feedProd, t in timePeriod)	
			offFeedSupRate[n][ep.feedType][t] == sum(i in hydForm, j in prodSize) prodRate[n][ep.prodTech][i][j][t] * ep.converRate;	  	
	
	//	 conservation of feedstock at each node
	constraint_130:
    	forall(n in node, ep in feedProd, efo in feedOnsiteFuel, t in timePeriod)
    	  	prodFeedSupRate[n][ep.feedType][t] + sum(m in node, le in tranFeed: le.feedType == ep.feedType) feedTranFlux[le][m][n][t]
    	  		== sum(m in node, le in tranFeed: le.feedType == ep.feedType) feedTranFlux[le][n][m][t] 
    	  			+ sum(i in hydForm, j in prodSize) prodRate[n][ep.prodTech][i][j][t] * ep.converRate
    	  			+ sum(j in onsiteFuelSize)onsiteFuelRate[n][efo.onsiteFuelTech][j][t]* efo.converRate;   	  			
    
    // feedstock supply rate cannot exceed certain limits
	constraint_16:
		forall(n in node, e in feedType, t in timePeriod)
		  	prodFeedSupRate[n][e][t] >= isFeed[n][e][t] * feedSupCapaMin [n][e];
	
	constraint_17:
		forall(n in node, e in feedType, t in timePeriod)
		  	prodFeedSupRate[n][e][t] <= isFeed[n][e][t] * feedSupCapaMax [n][e];
		  	 		  			
	
	///////////////////////////////production//////////////////////////////
    
    // the relationships among production
    constraint_03:
   		forall(n in node, t in timePeriod)
   		  	numProdTechFormSize[n][t] == sum(p in prodTech, i in hydForm, j in prodSize) numProd[n][p][i][j][t];	 													

	// production rate cannot exceed certain limits
	constraint_20:
		forall(n in node,  p in prodTech, i in hydForm, j in prodSize, t in timePeriod)
		  	prodRate[n][p][i][j][t] >= numProd[n][p][i][j][t] * prodCapaMin[p][i][j];

	constraint_21:
		forall(n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod)
		  	prodRate[n][p][i][j][t] <= numProd[n][p][i][j][t] * prodCapaMax[p][i][j];
	
	//	Production time constraints
	constraint_1031:
        forall(n in node, p in prodTech, i in hydForm, j in prodSize)
             numProd[n][p][i][j][1] == numProdNew[n][p][i][j][1] + numProdT0[n][p][i][j];
          
	constraint_103:
        forall(n in node, p in prodTech, i in hydForm, j in prodSize, t2 in timePeriod2)
             numProd[n][p][i][j][t2] == numProdNew[n][p][i][j][t2] + numProd[n][p][i][j][t2-1];

	constraint_1032:
        forall(n in node, p in prodTech, i in hydForm, j in prodSize, t2 in timePeriod2)
             numProd[n][p][i][j][t2] >=  numProd[n][p][i][j][t2-1];
             
    //	production site constraints 
    constraint_10331:
      forall(n in node)
            isProTime[n] <= sum(t in timePeriod)isPro[n][t]; 
                 
	constraint_1033:
      forall(n in node, t in timePeriod)
            numProdTechFormSize[n][t] <= isPro[n][t];         
		
 	///////////////////////////////co2 storage//////////////////////////////
 	// conservation of CO2 at each node
    constraint_15:
    	forall(n in node, t in timePeriod)
    	  	prodEmiRateProc[n][t] + sum(m in node) co2TranFlux[m][n][t] == sum(m in node) co2TranFlux[n][m][t] + co2ProcRate[n][t];
    
    // CO2 processing rate cannot exceed certain limits
	constraint_18:
		forall(n in node, t in timePeriod)
		  	co2ProcRate[n][t] >= isCO2StoRes[n][t] * co2ProcCapaMin[n];
	
	constraint_19:
		forall(n in node, t in timePeriod)
		  	co2ProcRate[n][t] <= isCO2StoRes[n][t] * co2ProcCapaMax[n];
		  	
 	// the production emission of a node cannot be processed if there is no plant at this node
	constraint_48:
		forall(n in node, t in timePeriod)
		  	isProdEmiProc[n][t] <= numProdTechFormSize[n][t];																						   
	
	constraint_49:
		forall(n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod)
		  	prodRateEmiProc[n][p][i][j][t] <= prodCapaMax[p][i][j] * isProdEmiProc[n][t];

	constraint_50:
		forall(n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod)
		  	prodRateEmiProc[n][p][i][j][t] <= prodRate[n][p][i][j][t];		  	

	constraint_51:
		forall(n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod)
		  	prodRateEmiProc[n][p][i][j][t] >= prodRate[n][p][i][j][t] - (1 - isProdEmiProc[n][t]) * prodCapaMax[p][i][j];
		  	
 	//	co2 storage time constraints
	constraint_1071:
        forall(n in node)
             isCO2StoRes[n][1] == isCO2StoResNew[n][1] + isCO2StoResT0[n];
	
	constraint_107:
        forall(n in node, t2 in timePeriod2)
             isCO2StoRes[n][t2] == isCO2StoResNew[n][t2] + isCO2StoRes[n][t2-1];
 	 	
	///////////////////////////////storage//////////////////////////////
            
    //the relationship related time period        
    constraint_1041:
        forall(n in node, i in hydForm, s in prodSize)
             numTer[n][i][s][1] == numTerNew[n][i][s][1] + numTerT0[n][i][s];
                      
	constraint_104:
        forall(n in node, i in hydForm, s in prodSize, t2 in timePeriod2)
             numTer[n][i][s][t2] == numTerNew[n][i][s][t2] + numTer[n][i][s][t2-1];	        
   	
   	constraint_1043:
        forall(n in node, i in hydForm, s in prodSize, t2 in timePeriod2)
             numTer[n][i][s][t2] >=  numTer[n][i][s][t2-1];	
             
   	//**production plante and storage facilities in the same node   
//   	 constraint_1042:
//        forall(n in node, i in hydForm, t in timePeriod)
//             sum(p in prodTech, j in prodSize)numProdNew[n][p][i][j][t] == sum(s in prodSize)numTerNew[n][i][s][t];
             
   	// storage rate cannot exceed certain limits
	constraint_201:
		forall(n in node, i in hydForm, s in prodSize, t in timePeriod)
		  	terRate[n][i][s][t] >= numTer[n][i][s][t] * terCapaMin[i][s];

	constraint_211:
		forall(n in node, i in hydForm, s in prodSize, t in timePeriod)
		  	terRate[n][i][s][t] <= numTer[n][i][s][t] * terCapaMax[i][s];
	
	constraint_212:
		forall(n in node, i in hydForm, s in prodSize, t in timePeriod)
		  	terRateFin[n][i][s][t] * opePeriod <= numTer[n][i][s][t] * terCapaMax[i][s] ;	 
	
	constraint_213:
		forall(n in node, i in hydForm, s in prodSize, t in timePeriod)
		  	terRateFin[n][i][s][t] * opePeriod >= numTer[n][i][s][t] * terCapaMin[i][s] ;
		  		  	
   	///////////////////////////////onsite fueling//////////////////////////////	  	   		  	
   	constraint_94:
   		forall(n in node, fo in onsiteFuelTech, t in timePeriod)
   		  	numFuelOnsiteSize[n][fo][t] == sum(j in onsiteFuelSize) numFuelOnsite[n][fo][j][t];	
   	  	
   	constraint_10:
   		forall(n in node, t in timePeriod)
   		  	numFuelOnsiteTechSize[n][t] == sum (fo in onsiteFuelTech) numFuelOnsiteSize[n][fo][t];
   	
   	// onsite fueling rate cannot exceed certain limits
   	constraint_24:
		forall(n in node, fo in onsiteFuelTech, j in onsiteFuelSize, t in timePeriod)
		  	onsiteFuelRate[n][fo][j][t] >= numFuelOnsite[n][fo][j][t] * onsiteFuelCapaMin[fo][j];
		  			  	
	constraint_25:
		forall(n in node, fo in onsiteFuelTech, j in onsiteFuelSize, t in timePeriod)
		  	onsiteFuelRate[n][fo][j][t] <= numFuelOnsite[n][fo][j][t] * onsiteFuelCapaMax[fo][j];	  				
	
	//	on-site refueling station time constraints
	constraint_1061:
        forall(n in node,fo in onsiteFuelTech, j in onsiteFuelSize)
            numFuelOnsite[n][fo][j][1] == numFuelOnsiteNew[n][fo][j][1] + numFuelOnsiteT0[n][fo][j];
	
	constraint_106:
        forall(n in node,fo in onsiteFuelTech, j in onsiteFuelSize, t2 in timePeriod2)
            numFuelOnsite[n][fo][j][t2] == numFuelOnsiteNew[n][fo][j][t2] + numFuelOnsite[n][fo][j][t2-1];
 
	///////////////////////////////offsite fueling//////////////////////////////
	
	// fueling rate cannot exceed certain limits
	constraint_22:
		forall(n in node, fs in standFuelTech, i in hydForm, j in fuelSize, t in timePeriod)
		  	standFuelRate[n][fs][i][j][t] >= numFuelStand[n][fs][i][j][t] * standFuelCapaMin[fs][i][j];
		  			  	
	constraint_23:
		forall(n in node, fs in standFuelTech, i in hydForm, j in fuelSize, t in timePeriod)
		  	standFuelRate[n][fs][i][j][t] <= numFuelStand[n][fs][i][j][t] * standFuelCapaMax[fs][i][j];
	
	//	off-site refueling station time constraints      
	constraint_1052:
        forall(n in node, t in timePeriod)
            sum(fs in standFuelTech, i in hydForm, j in fuelSize)numFuelStand[n][fs][i][j][t] >= isFuelStand[n][t];
    
    constraint_10521:
        forall(n in node,fs in standFuelTech, i in hydForm, j in fuelSize, t2 in timePeriod2)
            numFuelStand[n][fs][i][j][t2] >= numFuelStand[n][fs][i][j][t2-1];
             
	constraint_105:
        forall(n in node,fs in standFuelTech, i in hydForm, j in fuelSize)
            numFuelStand[n][fs][i][j][1] == numFuelStandNew[n][fs][i][j][1] + numFuelStandT0[n][fs][i][j];
	
	constraint_1051:
        forall( n in node,fs in standFuelTech, i in hydForm, j in fuelSize, t2 in timePeriod2)
            numFuelStand[n][fs][i][j][t2] ==  numFuelStandNew[n][fs][i][j][t2] + numFuelStand[n][fs][i][j][t2-1];

                      
	///////////////////////////////mass balance//////////////////////////////	
	  	    	  		  		
	constraint_1324:
    	forall(n in node, i in hydForm, j in prodSize,t in timePeriod)
    	    sum(p in prodTech)prodRate[n][p][i][j][t] == terRate[n][i][j][t];    	    		
  	
//  	constraint_1324:
//    	forall(n in node, i in hydForm,t in timePeriod)
//    	    sum(p in prodTech, j in prodSize)prodRate[n][p][i][j][t] == sum(j in prodSize)terRate[n][i][j][t];  
    	      
    constraint_13241:
    	forall(n in node, i in hydForm)
    	    sum(s in prodSize)terRate[n][i][s][1] + sum(s in prodSize)terRateFinT0[n][i][s] + sum(m in node) hydTranFlux2[i][m][n][1] 
    	    	+ sum(m in node)h2TranFluxPip2[i][m][n][1] 
    	    		== sum(s in prodSize)terRateFin[n][i][s][1] + sum(fs in standFuelTech, j in fuelSize) standFuelRate[n][fs][i][j][1]
    	    		+ sum(m in node) hydTranFlux2[i][n][m][1] + sum(m in node) h2TranFluxPip2[i][n][m][1];
    constraint_13242:
    	forall(n in node, i in hydForm, t2 in timePeriod2)
    	    sum(s in prodSize)terRate[n][i][s][t2] + sum(s in prodSize)terRateFin[n][i][s][t2-1]+ sum(m in node) hydTranFlux2[i][m][n][t2] 
    	    	+ sum(m in node)h2TranFluxPip2[i][m][n][t2] 
    	    		== sum(s in prodSize)terRateFin[n][i][s][t2] + sum(fs in standFuelTech, j in fuelSize) standFuelRate[n][fs][i][j][t2]
    	    		+ sum(m in node) hydTranFlux2[i][n][m][t2] + sum(m in node) h2TranFluxPip2[i][n][m][t2];

	
	///////////////////////////////transportation//////////////////////////////
		
    // **transportation flux cannot exceed certain limits
    constraint_262:
   		forall(i in hydForm, m in node, n in node, t in timePeriod)
   		  	hydTranFlux2[i][n][m][t] >= isHydTran2[i][n][m][t] * hydTranCapaMin2[i];  
	
	constraint_292:
   		forall(i in hydForm, m in node, n in node, t in timePeriod)
   		  	hydTranFlux2[i][n][m][t] <= isHydTran2[i][n][m][t] * hydTranCapaMax2[i];  		
   		  	
   	constraint_27:
   		forall(le in tranFeed, n in node, m in node, t in timePeriod)
   		  	feedTranFlux[le][n][m][t] >= isFeedTran[le][n][m][t] * feedTranCapaMin[le];

    constraint_30:
   		forall(le in tranFeed, n in node, m in node, t in timePeriod)
   		  	feedTranFlux[le][n][m][t] <= isFeedTran[le][n][m][t] * feedTranCapaMax[le];

   	constraint_28:
   		forall(n in node, m in node, t in timePeriod)
   		  	co2TranFlux[n][m][t] >= isCO2Tran[n][m][t] * co2TranCapaMin;

   	constraint_31:
   		forall(n in node, m in node, t in timePeriod)
   		  	co2TranFlux[n][m][t] <= isCO2Tran[n][m][t] * co2TranCapaMax;  	
   	
   	constraint_313:
   		forall(i in hydForm, n in node, m in node, t in timePeriod)
   			h2TranFluxPip2[i][n][m][t] >= isH2Tranpip2[i][n][m][t] * h2TranCapaPipMin;
   		
   	constraint_314:
   		forall(i in hydForm, n in node, m in node, t in timePeriod)
   			h2TranFluxPip2[i][n][m][t] <= isH2Tranpip2[i][n][m][t] * h2TranCapaPipMax;
   			
	// transportation between different nodes can only occur in one direction	
	constraint_322:
		forall(i in hydForm, n in node, m in node, t in timePeriod)
		  	isHydTran2[i][n][m][t] + isHydTran2[i][m][n][t] <= 1;	  	
		  	
	constraint_33:
		forall(le in tranFeed, n in node, m in node, t in timePeriod)
		  	isFeedTran[le][n][m][t] + isFeedTran[le][m][n][t] <= 1;

	constraint_34:
		forall(n in node, m in node, t in timePeriod)
		  	isCO2Tran[n][m][t] + isCO2Tran[m][n][t] <= 1;		
		  	  
	constraint_342:	  			
		forall(i in hydForm, n in node, m in node, t in timePeriod)
			isH2Tranpip2[i][n][m][t] + isH2Tranpip2[i][m][n][t] <= 1;	  		  			    		   
 	
 	constraint_343:	  			
		forall(i in hydForm, n in node, m in node, t in timePeriod)
			isHydTran2[i][n][m][t] + isHydTran2[i][m][n][t] 
			+ isH2Tranpip2[i][n][m][t] + isH2Tranpip2[i][m][n][t] <= 1;
 	// transportation direction constraints
 	
 	// feedstock transportation direction constraints
    constraint_41:				
    	forall( le in tranFeed, n in node,m in node, t in timePeriod)
//    	  	isFeed[n][e][t] >= isFeedTran[le][n][m][t];
    	  	isFeedType[n][t] >= isFeedTran[le][n][m][t];

    constraint_42:
    	forall(le in tranFeed, n in node, m in node, t in timePeriod)
    	  	numProdTechFormSize[n][t] >= isFeedTran[le][m][n][t];
 
 	// storage transportation direction constraints
    
//     constraint_391:	  	
//    	forall(i in hydForm, n in node, m in node, t in timePeriod)
// 		  	sum(p in prodTech,j in prodSize)numProd[n][p][i][j][t] >= isHydTran2[i][n][m][t]  ; 
// 	 constraint_3911:	  	
//    	forall(i in hydForm, n in node, m in node, t in timePeriod)
// 		  	sum(p in prodTech,j in prodSize)numProd[n][p][i][j][t] >= isH2Tranpip2[i][n][m][t]  ;	  	
 		  		  	 		  		  	 	
	constraint_3912:	  	
    	forall(i in hydForm, n in node, m in node, t in timePeriod)
 		  	sum(s in prodSize)numTer[n][i][s][t] >= isHydTran2[i][n][m][t]  ;
 	constraint_3913:	  	
    	forall(i in hydForm, n in node, m in node, t in timePeriod)
 		  	sum(s in prodSize)numTer[n][i][s][t] >= isH2Tranpip2[i][n][m][t]  ;	  	
    // H2 transportation direction constraints (second)
// 	constraint_592:
// 		forall(i in hydForm, n in node, m in node, t in timePeriod)
// 		  	isH2Tranpip2[i][m][n][t] >= numTerFormSize[n][t];
 		  	
//	constraint_452:
//		forall(i in hydForm, n in node, t in timePeriod)
//		   sum(s in stoSize)numTer[n][i][s][t] >= isFuelStand[n][t];
////		   isFuelStand[n][t] >= isH2Tranpip2[i][m][n][t];



 	// CO2 transportation direction constraints
 	constraint_59:
 		forall(n in node, m in node, t in timePeriod)
 		  	isProdEmiProc[n][t] >= isCO2Tran[n][m][t];
 		  	
 	constraint_45:
 		forall(n in node, m in node, t in timePeriod)
 		   isCO2StoRes[n][t] >= isCO2Tran[m][n][t];
 							   	
  	// number of second road transport vehicles (hydrogen)
	constraint_972:
		forall(i in hydForm, t in timePeriod)
			sum(n in node, m in node) hydTranFlux2[i][n][m][t] * ((2 * distOD[n][m] / speed) + loUnloTime) / (tranAva * tranCap[i]) <= numHydTranVehI2[i][t];
			
	// number of transport vehicles (feedstock)
	constraint_53:
		forall(le in tranFeed, t in timePeriod)
			numFeedTranVehI[le][t] >= sum(n in node, m in node) feedTranFlux[le][n][m][t] * ((2 * distOD[n][m] / le.speed) + le.loUnloTime) / (le.tranAva * le.tranCap);
 
	//	transportation time constraints   					
    constraint_1091:
		forall(i in hydForm, n in node, m in node)
			isH2Tranpip2[i][n][m][1] == isH2Tranpip2New[i][n][m][1] + isH2Tranpip2T0[i][n][m];
	constraint_109:
		forall(i in hydForm, n in node, m in node, t2 in timePeriod2)
			isH2Tranpip2[i][n][m][t2] == isH2Tranpip2New[i][n][m][t2] + isH2Tranpip2[i][n][m][t2-1];	
	constraint_1092:
		forall(i in hydForm, n in node, m in node, t2 in timePeriod2)
			isH2Tranpip2[i][n][m][t2]>= isH2Tranpip2[i][n][m][t2-1];			

		///////////////////////////////objective//////////////////////////////    						
//	constraint_1094:
//		forall(t in timePeriod)
//		   lcohTime[t] <= 20;	

////  total global warming potentials cannot 
//    constraint_9102:   	
//      	lcoh <= 50000;
      
    constraint_9101:
       gloWarmPotFac <= 1000000000;
//       gloWarmPotFac <= 18218522;     	  	  			  	
} 

 //// solution

tuple solFeedT{
	string label;
	int feedNode;
	string feedType;
	int timePeriod;
	float prodFeedSupRate;	
};
{solFeedT} solFeed = {<"feed", n, e,t, prodFeedSupRate[n][e][t]> | n in node, e in feedType, t in timePeriod: prodFeedSupRate[n][e][t] > 1};

tuple solProdT{
	string label;
	int prodNode;
	string prodTech;
	string prodForm;
	string prodSize;
	int timePeriod;
	float prodRate;
};
{solProdT} solProd = {<"prod", n,  p, i, j, t, prodRate[n][p][i][j][t]> | n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod: prodRate[n][p][i][j][t] > 1};
 
tuple solStandFuelT{
	string label;
	int standFuelNode;
	string standFuelTech;
	string standFuelForm;
	string standFuelSize;
	int timePeriod;
	float standFuelRate;	
};
{solStandFuelT} solStandFuel = {<"standFuel", n, fs, i, j,t, standFuelRate[n][fs][i][j][t]> | n in node, fs in standFuelTech, i in hydForm, j in fuelSize, t in timePeriod: standFuelRate[n][fs][i][j][t] > 1};

tuple solOnsiteFuelT{
	string label;
	int onsiteNode;
	string onsiteTech;
	string onsiteFuelSize;
	int timePeriod;
	float onsiteFuelRate;	
};
{solOnsiteFuelT} solOnsiteFuel = {<"onsiteFuelStation", n, fo, j , t, onsiteFuelRate[n][fo][j][t] > | n in node, fo in onsiteFuelTech,i in hydForm,j in onsiteFuelSize, t in timePeriod: onsiteFuelRate[n][fo][j][t] > 1};

tuple solCO2StoResT{
	string label;
	int co2Node;
	int timePeriod;
	float co2ProcRate;
};
{solCO2StoResT} solCO2StoRes = {<"co2StoRes", n, t, co2ProcRate[n][t]> | n in node, t in timePeriod: co2ProcRate[n][t] > 1};

tuple solHydTranT2{
	string label;
	string hydForm;
	int hydOriNode;
	int hydDesNode;
	int timePeriod;
	float hydTranFlux2;
};
{solHydTranT2} solHydTran2 = {<"hydTran2", i, n, m, t,  hydTranFlux2[i][n][m][t]> | i in hydForm, n in node, m in node, t in timePeriod: hydTranFlux2[i][n][m][t] > 1};

tuple soiTranFluxPipT2{
	string label;
	string hydForm;
	int hydOriNode;
	int hydDesNode;
	int timePeriod;
	float h2TranFluxPip2;
};
{soiTranFluxPipT2} soiTranFluxPip2 = {<"h2TranFluxPip2", i, n, m, t, h2TranFluxPip2[i][n][m][t]> | i in hydForm, n in node, m in node, t in timePeriod: h2TranFluxPip2[i][n][m][t] > 1};

tuple solCO2TranT{
	string label;
	int co2OriNode;
	int co2DesNode;	
	int timePeriod;			 
	float co2TranFlux;
};
{solCO2TranT} solCO2Tran = {<"co2Tran", n, m, t, co2TranFlux[n][m][t]> | n in node, m in node, t in timePeriod: co2TranFlux[n][m][t] > 1};

tuple solFeedTranT{
	string label;
	tranFeedT tranFeed;
	int feedOriNode;
	int feedDesNode;
	int timePeriod;
	float feedTranFlux;
};
{solFeedTranT} solFeedTran = {<"feedTran", le, n, m, t, feedTranFlux[le][n][m][t]> | le in tranFeed, n in node, m in node, t in timePeriod: feedTranFlux[le][n][m][t] > 1};

tuple solTerT{
	string label;
	int terNode;
	string terForm;
	string terSize;
	int timePeriod;
	float terRate;
	
};
{solTerT} solTer = {<"terminal", n, i, s, t, terRate[n][i][s][t]> | n in node, i in hydForm, s in prodSize, t in timePeriod: terRate[n][i][s][t] > 1};

tuple solTerFinT{
	string label;
	int terNode;
	string terForm;
	string terSize;
	int timePeriod;
	float terRateFin;	
};
{solTerFinT} solTerFin = {<"terminalFin", n, i, s, t, terRateFin[n][i][s][t]> | n in node, i in hydForm, s in prodSize, t in timePeriod: terRateFin[n][i][s][t] > 1};

//tuple soiTranPip1T{
//	string label;
//	tranHydT1 tranHyd1;
//	int h2OriNode;
//	int h2DesNode;
//	int timePeriod;
//	float h2TranPipLen1;
//};
//{soiTranPip1T} soiTranPip1 = {<"PipLen1",lh1, n, m, t, h2TranPip1[lh1][n][m][t]> | lh1 in tranHyd1, n in node, m in node, t in timePeriod: h2TranPip1[lh1][n][m][t] > 1};

tuple soiTranPipFormLen2T{
	string label;
	string hydForm;
	int h2OriNode;
	int h2DesNode;
	int timePeriod;
	float h2TranPipLen2;
};
{soiTranPipFormLen2T} soiTranPipFormLen2 = {<"PipLen2", i, n, m, t, h2TranPipFormLen2[i][n][m][t]> | i in hydForm, n in node, m in node, t in timePeriod: h2TranPipFormLen2[i][n][m][t] > 1};

//tuple solisProdNewT{
//	string label;
//	int prodnode;
//	string prodTech;
//	string prodForm;
//	string prodSize;
//	int timePeriod;
//	boolean isProdNew;
//};
//{solisProdNewT} solisProdNew = {<"ProdNew", n, p, i, j, t, isProdNew[n][p][i][j][t]> | n in node, p in prodTech, i in hydForm, j in prodSize, t in timePeriod: isProdNew[n][p][i][j][t] == 1};


//int numFeed_tot = sum(e in feedType) numFeed[e];
//int numProd_tot = sum(p in prodTech, i in hydForm, j in prodSize) numProd[p][i][j];
//int numSto_tot = sum(i in hydForm,s in stoSize)numstr[i][s];
//int numStandFuel_tot = sum(fs in standFuelTech, i in hydForm, j in fuelSize) numStandFuel[fs][i][j];
//int numOnsiteFuel_tot = sum(fo in onsiteFuelTech, j in onsiteFuelSize) numOnsiteFuel[fo][j];
//int numHydTranVehI_tot1 = sum(lh in tranHyd) numHydTranVehI1[lh];
//int numHydTranVehI_tot2 = sum(lh in tranHyd) numHydTranVehI2[lh];	
//int numFeedTranVehI_tot = sum(le in tranFeed) numFeedTranVehI[le];											  	 										   
//
//										   
//float prodRateTotal = sum (p in prodTech, i in hydForm, j in prodSize)prodRateTot[p][i][j];
//float onsiteFuelRateTotal = sum(fo in onsiteFuelTech, j in onsiteFuelSize)onsiteFuelRateTot[fo][j];
//float standFuelRateTottot = sum(fs in standFuelTech,i in hydForm,j in fuelSize)standFuelRateNode[fs][i][j]; 
float numFuelStandTot[n in node][t in timePeriod] = sum(fs in standFuelTech, i in hydForm, j in fuelSize)numFuelStand[n][fs][i][j][t];

//float tranFluRate1 = sum(lh in tranHyd, n in node,m in node)hydTranFlux1[lh][n][m];
//float tranFluRate2 = sum(lh in tranHyd, n in node,m in node)hydTranFlux2[lh][n][m];
//float h2TranFluxPip1_tot = sum(lh in tranHyd, n in node,m in node) h2TranFluxPip1[lh][n][m];
//float h2TranFluxPip2_tot = sum(lh in tranHyd, n in node,m in node) h2TranFluxPip2[lh][n][m];
float lcoh_kg = lcoh/ opePeriod ;  		
float feCost_kg = (EC )/ hydFuelDemTot/opePeriod  ;	
float prodCost_kg = prodCost / hydFuelDemTot/opePeriod ;
float strCost_kg = strCost / hydFuelDemTot/opePeriod ;
float tranCost_kg = tranCost / hydFuelDemTot/opePeriod ;
float fuCost_kg = fuCost / hydFuelDemTot/opePeriod ;
float gloWarmPotFac_kg =  sum(t in timePeriod)gloWarmPotFacnode[t] / hydFuelDemTot ;
float prodEmiaverage = sum(n in node, t in timePeriod)(emiProCO2[n][t] + 28 * emiProCH4 [n][t] + 265* emiProN2O[n][t])/sum(t in timePeriod)hydFuelDemNode[t];
float strEmiaverage = sum(n in node, t in timePeriod)(emiStrCO2[n][t] + 28 * emiStrCH4 [n][t] + 265* emiStrN2O[n][t])/sum(t in timePeriod)hydFuelDemNode[t];
float tranEmiaverage = sum(n in node, t in timePeriod)(emiTranCO2[n][t] + 28 * emiTranCH4[n][t] + 265* emiTranN2O[n][t])/sum(t in timePeriod)hydFuelDemNode[t];
float fuelEmiaverage = sum(n in node, t in timePeriod)(emiFueCO2[n][t] + 28 * emiFueCH4[n][t] + 265* emiFueN2O[n][t])/sum(t in timePeriod)hydFuelDemNode[t];
 
execute {	
	var filename = "model-1-GWP-16-14.csv";
	var file = new IloOplOutputFile(filename);
	var after = new Date();
	
	file.write("solutionTime",",",after.getTime()-temp,"\n")	
	
	file.write("lcoh",",",lcoh,"\n")
	file.write("lcoh_kg",",",lcoh_kg,"\n")
	file.write("lcohTime",",",lcohTime,"\n")	
	file.write("hydFuelDemNode",",",hydFuelDemNode,"\n")
    file.write("hydFuelProdTot",",",hydFuelProdTot,"\n")
      
//    file.write("prodRateTotal",",",prodRateTotal,"\n")
//    file.write("onsiteFuelRateTotal",",",onsiteFuelRateTotal,"\n")
//    file.write("tranFluRate1",",",tranFluRate1,"\n")
//    file.write("tranFluRate2",",",tranFluRate2,"\n")
//    file.write("h2TranFluxPip1_tot",",",h2TranFluxPip1_tot,"\n")
//    file.write("h2TranFluxPip2_tot",",",h2TranFluxPip2_tot,"\n")
//    file.write("standFuelRateTottot",",", standFuelRateTottot,"\n")
    file.write("numFuelStandTot",",", numFuelStandTot,"\n")
     
//	file.write("numFeed_tot",",",numFeed_tot,"\n")
//	file.write("numProd_tot",",",numProd_tot,"\n")
//  file.write("numSto_tot",",",numSto_tot,"\n")
//	file.write("numStandFuel_tot",",",numStandFuel_tot,"\n")
//	file.write("numOnsiteFuel_tot",",",numOnsiteFuel_tot,"\n")
//	file.write("numHydTranVehI_tot1",",",numHydTranVehI_tot1,"\n")
//	file.write("numHydTranVehI_tot2",",",numHydTranVehI_tot2,"\n")
//	file.write("numFeedTranVehI_tot",",",numFeedTranVehI_tot,"\n")
	file.write("co2TranPipLen_tot",",",co2TranPipLen,"\n")
	
	file.write("feCost_kg",",",feCost_kg,"\n")
	file.write("prodCost_kg",",",prodCost_kg,"\n")
	file.write("strCost_kg",",",strCost_kg,"\n")
	file.write("tranCost_kg",",",tranCost_kg,"\n")
	file.write("fuCost_kg",",",fuCost_kg,"\n")
	file.write("co2ProcRateTot",",",co2ProcRateTot,"\n")
	
	file.write("co2storCost",",",co2storCost,"\n")
	
	file.write("gloWarmPotFac_kg",",",gloWarmPotFac_kg,"\n")
	file.write("gloWarmPotFac_it_Time",",",gloWarmPotFac_it_Time,"\n")
	
	file.write("prodEmi",",", prodEmi,"\n")
	file.write("strEmi",",", strEmi,"\n")
	file.write("tranEmi",",",tranEmi,"\n")
	file.write("fuelEmi",",",fuelEmi,"\n") 

	file.write("prodEmiaverage",",", prodEmiaverage,"\n")
	file.write("strEmiaverage",",", strEmiaverage,"\n")
	file.write("tranEmiaverage",",",tranEmiaverage,"\n")
	file.write("fuelEmiaverage",",",fuelEmiaverage,"\n") 		
	
//	file.write("numHydTranVehI1",",",numHydTranVehI1,"\n")
	file.write("numHydTranVehI2",",",numHydTranVehI2,"\n")
//	file.write("numHydTranVehIDir",",",numHydTranVehIDir,"\n")
	
	for(var s in solFeed)
		file.write(s.label,",",s.feedNode,",",s.feedType,",",s.timePeriod,",",s.prodFeedSupRate,"\n")	
		
	for(var s in solProd)
		file.write(s.label,",",s.prodNode,",",s.prodTech,",",s.prodForm,",",s.prodSize,",",s.timePeriod,",",s.prodRate,"\n")	
    for(var s in solTer)
		file.write(s.label,",",s.terNode,",",s.terForm,",",s.terSize,",",s.timePeriod,",",s.terRate,"\n");
	for(var s in solTerFin)
		file.write(s.label,",",s.terNode,",",s.terForm,",",s.terSize,",",s.timePeriod,",",s.terRateFin,"\n");					
	for(var s in solStandFuel)
		file.write(s.label,",",s.standFuelNode,",",s.standFuelTech,",",s.standFuelForm,",",s.standFuelSize,",",s.timePeriod,",",s.standFuelRate,"\n")
	for(var s in solOnsiteFuel)
		file.write(s.label,",",s.onsiteNode,",",s.onsiteTech,",",s.onsiteFuelSize,",",s.timePeriod,",",s.onsiteFuelRate,"\n")
    for(var s in solCO2StoRes)
		file.write(s.label,",",s.co2Node,",",s.timePeriod,",",s.co2ProcRate,"\n")					   													  
//	for(var s in solHydTran1)
//		file.write(s.label,",",s.tranHyd1.hydForm,",",s.hydOriNode,",",s.hydDesNode,",",s.timePeriod,",",s.hydTranFlux1,"\n")
//			
//	for(var s in soiTranFluxPip1)
//		file.write(s.label,",",s.tranHyd1.hydForm,",",s.hydOriNode,",",s.hydDesNode,",",s.timePeriod,",",s.h2TranFluxPip1,"\n")		
		
	for(var s in solHydTran2)
		file.write(s.label,",",s.hydForm,",",s.hydOriNode,",",s.hydDesNode,",",s.timePeriod,",",s.hydTranFlux2,"\n")	
	
//	for(var s in solHydTran3)
//		file.write(s.label,",",s.tranHyd1.hydForm,",",s.hydOriNode,",",s.hydDesNode,",",s.timePeriod,",",s.hydTranFluxDir,"\n")	
		
	for(var s in soiTranFluxPip2)
		file.write(s.label,",",s.hydForm,",",s.hydOriNode,",",s.hydDesNode,",",s.timePeriod,",",s.h2TranFluxPip2,"\n")
				
	for(var s in solFeedTran)
		file.write(s.label,",",s.tranFeed.feedType,",",s.feedOriNode,",", s.feedDesNode,",",s.timePeriod,",",s.feedTranFlux,"\n")
	for(var s in solCO2Tran)
		file.write(s.label,",",s.co2OriNode,",",s.co2DesNode,",",s.timePeriod,",",s.co2TranFlux,"\n")
	
//	for(var s in soiTranPip1)
//		file.write(s.label,",",s.tranHyd1.hydForm,",",s.h2OriNode,",",s.h2DesNode,",",s.timePeriod,",",s.h2TranPipLen1,"\n")	
	for(var s in soiTranPipFormLen2)
		file.write(s.label,",",s.hydForm,",",s.h2OriNode,",",s.h2DesNode,",",s.timePeriod,",",s.h2TranPipLen2,"\n")
					   													  
	file.close();
}