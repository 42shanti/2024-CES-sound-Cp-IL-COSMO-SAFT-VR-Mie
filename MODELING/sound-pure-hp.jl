print(@__FILE__)
print("\n")
# all high pressure sound evaluation
# bs04

# READ EXPERIMENTAL DATA
    full_file_path_msound = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/sound/hp_all_sound.csv"]
    full_file_path_T = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/sound/hp_all_temperature.csv"]

# PACKAGES
    using Clapeyron # https://github.com/ClapeyronThermo/Clapeyron.jl
    using CSV
    using DataFrames
    using Statistics
    using PyCall
    import PyPlot

# INPUT
    pressure = 101320E+03 # Pa
    exp_data = 4 # number of experimental procedures evaluated

    species1="C2MIMTF2N_2B"
    species2="C4MIMTF2N_2B"
    species3="C5MIMTF2N_2B"
    species4="C6MIMTF2N_2B"

    species = [species1,species2,species3,species4]

# GENERATE MODELS
    model1=SAFTVRMie([species1]; idealmodel = JobackIdeal)
    model2=SAFTVRMie([species2]; idealmodel = JobackIdeal)
    model3=SAFTVRMie([species3]; idealmodel = JobackIdeal)
    model4=SAFTVRMie([species4]; idealmodel = JobackIdeal)

    models = [model1,model2,model3,model4]

    n_models = length(models) # number of models evaluated

# EXPERIMENTAL DATA
    expdata_msound = CSV.read(full_file_path_msound,DataFrame)
    expdata_T = CSV.read(full_file_path_T,DataFrame)
    print(expdata_msound)
    print("\n")
# ORGANIZE EXPERIMENTAL DATA
    exp_msound = []
    exp_T = []
    all_exp_msound = []
    all_exp_T = []
    for i ∈ 1:exp_data
        valid_msound = dropmissing(expdata_msound,[i])
        append!(exp_msound,[valid_msound[:,i]])
        append!(all_exp_msound,valid_msound[:,i])
        valid_T = dropmissing(expdata_T,[i])
        append!(exp_T,[valid_T[:,i]])
        append!(all_exp_T,valid_T[:,i])    
    end
    print("exp_msound[1] = ",exp_msound[1])
    print("\n")
# EXPERIMENTAL INTERVALS
    min_exp_msound = minimum(all_exp_msound) # J/K/mol
    print("min_exp_msound = ",min_exp_msound)
    print("\n")
    max_exp_msound = maximum(all_exp_msound) # J/K/mol
    print("max_exp_msound = ",max_exp_msound)
    print("\n")
    min_exp_T = minimum(all_exp_T) # K
    print("min_exp_T = ",min_exp_T)
    print("\n")
    max_exp_T = maximum(all_exp_T) # K
    print("max_exp_T = ",max_exp_T)
    print("\n")
    delta_T = max_exp_T - min_exp_T # K
    print("delta_T = ",delta_T)
    print("\n")
    length_T = trunc(Int,delta_T) # convert delta_T to integer
    print("length_T = ",length_T)
    print("\n")
#

# OBTAIN speed of sound with 'speed_of_sound' function
    T = [] # K
    model_msound = [] # g/L == kg/m³
    for i ∈ 1:n_models
        append!(T,[range(min_exp_T,max_exp_T+1,length_T)])   
        s_s = speed_of_sound.(models[i], pressure, T[i])
        append!(model_msound,[[s_s[i][1] for i ∈ 1:length_T]])
    end

# PLOT CnmimTf2N
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL   
    PyPlot.plot(exp_T[1],exp_msound[1],label="[C₂mim][Tf₂N]",linestyle="",marker="^",color="black")
    PyPlot.plot(exp_T[2],exp_msound[2],label="[C₄mim][Tf₂N]",linestyle="",marker="s",color="royalblue")
    PyPlot.plot(exp_T[3],exp_msound[3],label="[C₅mim][Tf₂N]",linestyle="",marker="o",color="hotpink")
    PyPlot.plot(exp_T[4],exp_msound[4],label="[C₆mim][Tf₂N]",linestyle="",marker="x",color="forestgreen")
# PLOT MODEL
    PyPlot.plot(T[1],model_msound[1],label="",linestyle="dashed",color="black")
    PyPlot.plot(T[2],model_msound[2],label="",linestyle="dashed",color="royalblue")
    PyPlot.plot(T[3],model_msound[3],label="",linestyle="dashed",color="hotpink")
    PyPlot.plot(T[4],model_msound[4],label="",linestyle="dashed",color="forestgreen")
    #
# PLOT AXES
    PyPlot.text(300,1520, "High-pressure systems (1013.2 bar)", fontsize=14)
    PyPlot.legend(loc="lower left",frameon=false,fontsize=16,ncol=1)
    PyPlot.xlabel("Temperature (K)",fontsize=16)
    PyPlot.ylabel("Speed of sound (m/s)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    PyPlot.ylim([1419,1530])
display(PyPlot.gcf())
#