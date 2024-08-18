print(@__FILE__)
print("\n")
@time begin
# H_E

################
### PACKAGES ###
################
using Clapeyron
using CSV
using DataFrames
using Statistics
using LaTeXStrings
using PyCall
import PyPlot

#############
### INPUT ###
#############
T1 = 323.15 # K
length_T = 1 # number of temperatures evaluated

P_1 = 101.0E+03 # Pa

pretty_species_all = [
    "[C₂mim][SCN]" # 1
    "[C₄mim][SCN]" # 2
    "[C₆mim][SCN]" # 3
    "[C₂mim][TfO]" # 4
    "[C₄mim][TfO]" # 5
    "[C₈mim][TfO]" # 6
    "[C₂mim][Tf₂N]" # 7
    "[C₄mim][Tf₂N]" # 8
    "[C₅mim][Tf₂N]" # 9
    "[C₆mim][Tf₂N]" # 10
    "[C₈mim][Tf₂N]" # 11
]
pretty_species = pretty_species_all[7]

species = "C2MIMTF2N" # as written on CSV files
# species_solute = "ethanol_2B"
# species_solute = "ethanol_polishuk"
# species_solute = "ethanol_test"
species_solute = "ethanol_cri2B4"
species_NA = "C2MIMTF2N_NA"
species_2B = "C2MIMTF2N_2B"
species_4C = "C2MIMTF2N"

Y_TICKS = collect(0:500:5000)
Y_LIM = 0,3000

####################
### EXPERIMENTAL ###
####################
path_x = ["C:/Users/cleiton/My Drive/usp-brainstorm/bs04/csv/H_E/x-eC2MIMTF2N.csv"]
path_y = ["C:/Users/cleiton/My Drive/usp-brainstorm/bs04/csv/H_E/y-eC2MIMTF2N.csv"]
# path_x = ["C:/Users/clsobe/My Drive/usp-brainstorm/bs04/csv/H_E/x-eC2MIMTF2N.csv"]
# path_y = ["C:/Users/clsobe/My Drive/usp-brainstorm/bs04/csv/H_E/y-eC2MIMTF2N.csv"]
# READ EXPERIMENTAL DATA
expdata_x = CSV.read(path_x,DataFrame)
expdata_y = CSV.read(path_y,DataFrame)
# ORGANIZE EXPERIMENTAL DATA
exp_x = [] # mole fraction [solute]
exp_y = [] # m3/mol
all_exp_x = []
all_exp_y = []
for i ∈ 1:length_T
    valid_x = dropmissing(expdata_x,[i]) # important for plotting
    append!(exp_x,[valid_x[:,i]])
    append!(all_exp_x,valid_x[:,i])
    valid_y = dropmissing(expdata_y,[i])
    append!(exp_y,[valid_y[:,i]])
    append!(all_exp_y,valid_y[:,i])
end
# EXP BOUNDARIES
min_exp_y = minimum(all_exp_y) # m3/mol
max_exp_y = maximum(all_exp_y) # m3/mol
min_exp_x = minimum(all_exp_x) # mole fraction
max_exp_x = maximum(all_exp_x) # mole fraction
# ORGANIZE BOUNDARIES
x_interval = (0.0:0.01:1.0)
X_interval = Clapeyron.FractionVector.(x_interval) # builds a vector [x_interval, 1-x_interval]

################
### MODELING ###
################
# GENERATE MODELS
model_NA = SAFTVRMie([species_solute,species_NA])
model_2B = SAFTVRMie([species_solute,species_2B])
model_4C = SAFTVRMie([species_solute,species_4C])
# EXCESS FUNCTION prop_E=excess(model,p,T,z,property)
model_y_NA_T1=excess.(model_NA, P_1, T1, X_interval, enthalpy; phase=:liquid)
model_y_2B_T1=excess.(model_2B, P_1, T1, X_interval, enthalpy; phase=:liquid)
model_y_4C_T1=excess.(model_4C, P_1, T1, X_interval, enthalpy; phase=:liquid)
#

################
### PLOTTING ###
################
PyPlot.clf()
PyPlot.rc("font", family="times new roman")
PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL
# species = C2MIMTF2N ₀₁₂₃₄₅₆₇₈₉
# T1
PyPlot.plot(exp_x[1],exp_y[1],label=string(T1," ","K"),linestyle="",marker="^",color="black")
PyPlot.plot(exp_x[1],exp_y[1],label=pretty_species,linestyle="")
# PLOT MODEL
PyPlot.plot(x_interval,model_y_NA_T1,label="",linestyle="dotted",color="black")
PyPlot.plot(x_interval,model_y_2B_T1,label="",linestyle="dashed",color="black")
PyPlot.plot(x_interval,model_y_4C_T1,label="",linestyle="solid",color="black")
# PLOT AXES
PyPlot.legend(loc="best",frameon=false,fontsize=18)
PyPlot.xlabel("Ethanol mole fraction",fontsize=16)
PyPlot.ylabel("H" *L"\rm{^E}" *" (Jmol⁻¹)",fontsize=16)
PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)
PyPlot.xlim(0.0,1.0)
PyPlot.yticks(Y_TICKS)
PyPlot.ylim(Y_LIM)
display(PyPlot.gcf())
# ₀₁₂₃₄₅₆₇₈₉
end#@time