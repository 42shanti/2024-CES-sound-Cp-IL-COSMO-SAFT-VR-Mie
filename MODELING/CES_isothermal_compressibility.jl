print(@__FILE__)
print("\n")
# kT isothermal_compressibility
# AARD and plot

################
### PACKAGES ###
################
using Clapeyron
# using BlackBoxOptim
using CSV
using DataFrames
using Statistics
using Printf
using LaTeXStrings
using PyCall
import PyPlot

#############
### INPUT ###
#############
species_IL = "C4MIMTF2N_2B"
cute_species = "[C₄mim][Tf₂N]"
fig_title = species_IL


####################
### EXPERIMENTAL ###
####################
username = ENV["USERNAME"]
# exp_path = ["C:/Users/"*username*"/My Drive/PROJECTS/DTU/BS5/CSV/RHO/C4MIMTF2N.csv"]
# exp_path = ["C:/Users/clsobe/My Drive/usp-manuscript/manuscript-04/submit/MS4-R2/MS4R2_CSV/kT_C4MIMTF2N.csv"]
exp_path = ["C:/Users/cleiton/My Drive/usp-manuscript/manuscript-04/submit/MS4-R2/MS4R2_CSV/kT_C4MIMTF2N.csv"]

exp_data = CSV.read(exp_path,DataFrame)

data_kT = exp_data[:,1] # [GPa-1]
data_P = exp_data[:,2] # [MPa]
data_T = exp_data[:,3] # [K]

Ndatapoins = length(data_P)

kT_min = minimum(data_kT)
kT_max = maximum(data_kT)

P_min = minimum(data_P)
P_max = maximum(data_P)

T_min = minimum(data_T)
T_max = maximum(data_T)

print("data_P,data_T,data_kT,datapoints,AARD%:")
print("\n")

@printf("%.1f",P_min)
print("–")
@printf("%.1f",P_max)

print(",")

@printf("%.2f",T_min)
print("–")
@printf("%.2f",T_max)

print(",")

@printf("%.3f",kT_min)
print("–")
@printf("%.3f",kT_max)

print(",")

print(Ndatapoins)

################
### MODELING ###
################
model_IL = SAFTVRMie([species_IL])

# isothermal_compressibility(model::EoSModel, p, T, z=SA[1.]; phase=:unknown, threaded=true, vol0=nothing)
model_kT = isothermal_compressibility.(model_IL,data_P*1E6,data_T; phase=:liquid)

# RELATIVE DEVIATION
RD_kT = model_kT*1.0e9 - data_kT
# AVERAGE ABSOLUTE RD
print(",")
AARD_kT = 100*(mean(abs.(RD_kT ./ data_kT)))
@printf("%.1f",AARD_kT)
print("\n")

################
### PLOTTING ###
################
PyPlot.clf()
plot_font = "times new roman"
PyPlot.rc("font", family=plot_font)
PyPlot.figure(figsize=(9,9), dpi = 311)
# EXPERIMENTAL
PyPlot.plot(data_P[1:34],data_kT[1:34],label="298.15 K",linestyle="",marker="^",color="black")
PyPlot.plot(data_P[35:68],data_kT[35:68],label="303.15 K",linestyle="",marker="s",color="royalblue")
PyPlot.plot(data_P[69:102],data_kT[69:102],label="308.15 K",linestyle="",marker="o",color="hotpink")
PyPlot.plot(data_P[103:136],data_kT[103:136],label="313.15 K",linestyle="",marker="x",color="forestgreen")
PyPlot.plot(data_P[137:170],data_kT[137:170],label="318.15 K",linestyle="",marker="<",color="orange")
PyPlot.plot(data_P[171:204],data_kT[171:204],label="323.15 K",linestyle="",marker="D",color="red")
# MODEL
PyPlot.plot(data_P[1:34],1.0e9*model_kT[1:34],label="",linestyle="dashed",marker="",color="black")
PyPlot.plot(data_P[35:68],1.0e9*model_kT[35:68],label="",linestyle="dashed",marker="",color="royalblue")
PyPlot.plot(data_P[69:102],1.0e9*model_kT[69:102],label="",linestyle="dashed",marker="",color="hotpink")
PyPlot.plot(data_P[103:136],1.0e9*model_kT[103:136],label="",linestyle="dashed",marker="",color="forestgreen")
PyPlot.plot(data_P[137:170],1.0e9*model_kT[137:170],label="",linestyle="dashed",marker="",color="orange")
PyPlot.plot(data_P[171:204],1.0e9*model_kT[171:204],label="",linestyle="dashed",marker="",color="red")
# 
PyPlot.legend(loc="best",frameon=false,fontsize=24)
PyPlot.xlabel("Pressure (MPa)",fontsize=24)
PyPlot.ylabel("κ"*L"\rm{_T}"*" (GPa⁻¹)",fontsize=24)
PyPlot.xticks(fontsize=18)
PyPlot.yticks(fontsize=18)
PyPlot.xticks(collect(0:25:150))
PyPlot.xlim([0,150])
PyPlot.yticks(collect(0.28:0.04:0.6))
PyPlot.ylim([0.28,0.6])
#
display(PyPlot.gcf())
