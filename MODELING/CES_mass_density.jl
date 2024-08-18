print(@__FILE__)
print("\n")
# RHO
# PLOTTING

################
### PACKAGES ###
################
using Clapeyron
using CSV
using DataFrames
using Statistics
using LaTeXStrings
using Printf
using PyCall
import PyPlot

#############
### INPUT ###
#############
# species_NA = "C2MIMTFO_NA"
species_2B = "C2MIMTFO_2B"
# species_4C = "C2MIMTFO"

####################
### EXPERIMENTAL ###
####################
username = ENV["USERNAME"]
exp_path = ["C:/Users/"*username*"/My Drive/usp-brainstorm/bs04/csv/rho/C2MIMTFO.csv"]
# exp_path = ["C:/Users/clsobe/My Drive/usp-brainstorm/bs04/csv/rho/C2MIMTFO.csv"]
# exp_path = ["C:/Users/cleiton/My Drive/usp-brainstorm/bs04/csv/rho/C2MIMTFO.csv"]

exp_data = CSV.read(exp_path,DataFrame)

data_rho = exp_data[:,1] # [kg/m3]
data_P = exp_data[:,2] # [kPa]
data_T = exp_data[:,3] # [K]

################
### MODELING ###
################
# model_NA = SAFTVRMie([species_NA])
model_2B = SAFTVRMie([species_2B])
# model_4C = SAFTVRMie([species_4C])

# mass_density(model::EoSModel, p, T, z=SA[1.]; phase=:unknown, threaded=true)
# property_NA = mass_density.(model_NA,data_P*1000,data_T; phase=:liquid)
property_2B = mass_density.(model_2B,data_P*1000,data_T; phase=:liquid)
# property_4C = mass_density.(model_4C,data_P*1000,data_T; phase=:liquid)

################
### PLOTTING ###
################
PyPlot.clf()
plot_font = "times new roman"
PyPlot.rc("font", family=plot_font)
PyPlot.figure(dpi=311)
# PyPlot.figure(dpi=420)

PyPlot.plot(data_rho,data_P*1e-3,label="[C₂mim][TfO]",linestyle="",marker="^",color="black")
# PyPlot.plot(data_rho,data_P*1e-3,label="[C₂mim][SCN]",linestyle="",marker="^",color="black")
# PyPlot.plot(property_2B,data_P*1e-3,label="SAFT-VR Mie",linestyle="dashed",marker="",color="black")

# [C₂mim][TfO]
PyPlot.plot(property_2B[1:18],data_P[1:18]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[19:40],data_P[19:40]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[41:62],data_P[41:62]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[63:84],data_P[63:84]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[85:106],data_P[85:106]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[107:128],data_P[107:128]*1e-3,label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(property_2B[129:150],data_P[129:150]*1e-3,label="",linestyle="dashed",marker="",color="black")

# [C₂mim][SCN]
# 298.15 K
# 308.15 K
# 318.15 K
# 328.15 K
# 338.15 K
# PyPlot.plot(property_2B[1:13],data_P[1:13]*1e-3,label="",linestyle="dashed",marker="",color="black")
# PyPlot.plot(property_2B[14:26],data_P[14:26]*1e-3,label="",linestyle="dashed",marker="",color="black")
# PyPlot.plot(property_2B[27:39],data_P[27:39]*1e-3,label="",linestyle="dashed",marker="",color="black")
# PyPlot.plot(property_2B[40:52],data_P[40:52]*1e-3,label="",linestyle="dashed",marker="",color="black")
# PyPlot.plot(property_2B[53:65],data_P[53:65]*1e-3,label="",linestyle="dashed",marker="",color="black")

PyPlot.legend(loc="best",frameon=false,fontsize=16)

PyPlot.xlabel("Density (kg/m³)",fontsize=16)
PyPlot.ylabel("Pressure (MPa)",fontsize=16)

PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)

# PyPlot.xticks(collect(1325:25:1400))

# PyPlot.xlim([1325,1400])
# PyPlot.ylim([0,70])

# PyPlot.text(property_2B[150],700, "298.15 K, 313.15 K, 323.15 K, 333.15 K, 343.15 K, 353.15 K, 363.16 K", fontsize=14)

display(PyPlot.gcf())