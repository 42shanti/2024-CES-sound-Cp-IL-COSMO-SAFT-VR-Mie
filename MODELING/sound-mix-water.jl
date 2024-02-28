print(@__FILE__)
print("\n")
# sound evaluation mixture water
# bs04

# PACKAGES
    using Clapeyron # https://github.com/ClapeyronThermo/Clapeyron.jl
    using CSV
    using DataFrames
    using Statistics
    using PyCall
    import PyPlot

# INPUT
    T1 = 298.15 # K
    T2 = 338.15 # K
    length_T = 2 # number of temperature evaluated
    species = "C4MIMTFO"
    cute_species = "IL: [C₄mim][TfO]"

# EXPERIMENTAL PATH
    full_file_path_x = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/binary-sound/x-wC4MIMTFO.csv"] # composition file
    full_file_path_sound = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/binary-sound/y-wC4MIMTFO.csv"] # sound file
# READ EXPERIMENTAL DATA
    expdata_x = CSV.read(full_file_path_x,DataFrame)
    expdata_sound = CSV.read(full_file_path_sound,DataFrame)
# ORGANIZE EXPERIMENTAL DATA
    exp_x = [] # mole fraction
    exp_sound = [] # m/s
    all_exp_x = []
    all_exp_sound = []
    for i ∈ 1:length_T
        valid_x = dropmissing(expdata_x,[i]) # remove missing values
        append!(exp_x,[valid_x[:,i]])
        append!(all_exp_x,valid_x[:,i])
        valid_sound = dropmissing(expdata_sound,[i])
        append!(exp_sound,[valid_sound[:,i]])
        append!(all_exp_sound,valid_sound[:,i])
    end
# EXP BOUNDARIES
    min_exp_sound = minimum(all_exp_sound) # m/s
    max_exp_sound = maximum(all_exp_sound) # m/s
    min_exp_x = minimum(all_exp_x) # mole fraction
    max_exp_x = maximum(all_exp_x) # mole fraction
# ORGANIZE BOUNDARIES
    x_interval = (min_exp_x-0.01:0.01:max_exp_x+0.03)
#

#######
########
#########
##########
# MODELING

# INPUT MODEL
    pressure = 101.0E+03 # Pa

    species_solute = "water_LJ"
    species_NA = "C4MIMTFO_NA"
    species_2B = "C4MIMTFO_2B"
    species_4C = "C4MIMTFO"

    X_interval = Clapeyron.FractionVector.(x_interval)

# GENERATE MODELS
    model_NA = SAFTVRMie([species_solute,species_NA]; idealmodel = JobackIdeal)
    model_2B = SAFTVRMie([species_solute,species_2B]; idealmodel = JobackIdeal)
    model_4C = SAFTVRMie([species_solute,species_4C]; idealmodel = JobackIdeal)

# OBTAIN speed of sound with 'speed_of_sound' function
    # T1
    model_sound_NA_T1=speed_of_sound.(model_NA, pressure, T1, X_interval; phase=:liquid)
    model_sound_2B_T1=speed_of_sound.(model_2B, pressure, T1, X_interval; phase=:liquid)
    model_sound_4C_T1=speed_of_sound.(model_4C, pressure, T1, X_interval; phase=:liquid)
    # T2
    model_sound_NA_T2=speed_of_sound.(model_NA, pressure, T2, X_interval; phase=:liquid)
    model_sound_2B_T2=speed_of_sound.(model_2B, pressure, T2, X_interval; phase=:liquid)
    model_sound_4C_T2=speed_of_sound.(model_4C, pressure, T2, X_interval; phase=:liquid)
#

###
####
#####
######
# PLOT
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL
    # species = C4MIMTFO ₀₁₂₃₄₅₆₇₈₉
    # T1
    PyPlot.plot(exp_x[1],exp_sound[1],label=cute_species,linestyle="")
    PyPlot.plot(exp_x[1],exp_sound[1],label=string(T1," ","K"),linestyle="",marker="^",color="black")
    # T2
    PyPlot.plot(exp_x[2],exp_sound[2],label=string(T2," ","K"),linestyle="",marker="s",color="royalblue")
# PLOT MODEL
    # T1
    PyPlot.plot(x_interval,model_sound_NA_T1,label="",linestyle="dotted",color="black")
    PyPlot.plot(x_interval,model_sound_2B_T1,label="",linestyle="dashed",color="black")
    PyPlot.plot(x_interval,model_sound_4C_T1,label="",linestyle="solid",color="black")
    # T2
    PyPlot.plot(x_interval,model_sound_NA_T2,label="",linestyle="dotted",color="royalblue")
    PyPlot.plot(x_interval,model_sound_2B_T2,label="",linestyle="dashed",color="royalblue")
    PyPlot.plot(x_interval,model_sound_4C_T2,label="",linestyle="solid",color="royalblue")
    # PLOT AXES
    PyPlot.legend(loc="upper left",frameon=false,fontsize=16)
    PyPlot.xlabel("Water mole fraction",fontsize=16)
    PyPlot.ylabel("Speed of sound (m/s)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    PyPlot.xlim([min_exp_x-0.01,0.72])
    # PyPlot.xlim([min_exp_x,0.899])
    # PyPlot.ylim([min_exp_sound-70,max_exp_sound+90])
    # PyPlot.xlim([model_sound[1][end],model_sound[1][begin]])
    # PyPlot.ylim([T[1][begin],T[1][end]])
    # PyPlot.ylim([500,2000])
    # PyPlot.text(0.07.*x_final,P_final./(1.8), "CO₂–[C₈mim][Tf₂N]", fontsize=16)
    display(PyPlot.gcf())
# ₀₁₂₃₄₅₆₇₈₉