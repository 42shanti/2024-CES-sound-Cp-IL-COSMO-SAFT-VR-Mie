print(@__FILE__)
print("\n")
# all sound evaluation
# bs04

# READ EXPERIMENTAL DATA
    full_file_path_msound = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/sound/mix_msound.csv"]
    full_file_path_T = ["C:/Users/bc_usp/My Drive (cleitonberaldo@usp.br)/usp-brainstorm/bs04/csv/sound/mix_T.csv"]

# PACKAGES
    using Clapeyron # https://github.com/ClapeyronThermo/Clapeyron.jl
    using CSV
    using DataFrames
    using Statistics
    using PyCall
    import PyPlot

# INPUT
    pressure = 101.325E+03 # Pa
    exp_data = 11 # number of experimental procedures evaluated

    species1="C2MIMSCN_NA"
    species2="C4MIMSCN_NA"
    species3="C6MIMSCN_NA"
    species4="C2MIMTFO_NA"
    species5="C4MIMTFO_NA"
    species6="C8MIMTFO_NA"
    species7="C2MIMTF2N_NA"
    species8="C4MIMTF2N_NA"
    species9="C5MIMTF2N_NA"
    species10="C6MIMTF2N_NA"
    species11="C8MIMTF2N_NA"

    species12="C2MIMSCN_2B"
    species13="C4MIMSCN_2B"
    species14="C6MIMSCN_2B"
    species15="C2MIMTFO_2B"
    species16="C4MIMTFO_2B"
    species17="C8MIMTFO_2B"
    species18="C2MIMTF2N_2B"
    species19="C4MIMTF2N_2B"
    species20="C5MIMTF2N_2B"
    species21="C6MIMTF2N_2B"
    species22="C8MIMTF2N_2B"

    species23="C2MIMSCN"
    species24="C4MIMSCN"
    species25="C6MIMSCN"
    species26="C2MIMTFO"
    species27="C4MIMTFO"
    species28="C8MIMTFO"
    species29="C2MIMTF2N"
    species30="C4MIMTF2N"
    species31="C5MIMTF2N"
    species32="C6MIMTF2N"
    species33="C8MIMTF2N"

    species = [species1,species2,species3,species4,species5,species6,species7,species8,species9,species10,species11,species12,species13,species14,species15,species16,species17,species18,species19,species20,species21,species22,species23,species24,species25,species26,species27,species28,species29,species30,species31,species32,species33]
#

# GENERATE MODELS
    model1=SAFTVRMie([species1]; idealmodel = JobackIdeal)
    model2=SAFTVRMie([species2]; idealmodel = JobackIdeal)
    model3=SAFTVRMie([species3]; idealmodel = JobackIdeal)
    model4=SAFTVRMie([species4]; idealmodel = JobackIdeal)
    model5=SAFTVRMie([species5]; idealmodel = JobackIdeal)
    model6=SAFTVRMie([species6]; idealmodel = JobackIdeal)
    model7=SAFTVRMie([species7]; idealmodel = JobackIdeal)
    model8=SAFTVRMie([species8]; idealmodel = JobackIdeal)
    model9=SAFTVRMie([species9]; idealmodel = JobackIdeal)
    model10=SAFTVRMie([species10]; idealmodel = JobackIdeal)
    model11=SAFTVRMie([species11]; idealmodel = JobackIdeal)
    model12=SAFTVRMie([species12]; idealmodel = JobackIdeal)
    model13=SAFTVRMie([species13]; idealmodel = JobackIdeal)
    model14=SAFTVRMie([species14]; idealmodel = JobackIdeal)
    model15=SAFTVRMie([species15]; idealmodel = JobackIdeal)
    model16=SAFTVRMie([species16]; idealmodel = JobackIdeal)
    model17=SAFTVRMie([species17]; idealmodel = JobackIdeal)
    model18=SAFTVRMie([species18]; idealmodel = JobackIdeal)
    model19=SAFTVRMie([species19]; idealmodel = JobackIdeal)
    model20=SAFTVRMie([species20]; idealmodel = JobackIdeal)
    model21=SAFTVRMie([species21]; idealmodel = JobackIdeal)
    model22=SAFTVRMie([species22]; idealmodel = JobackIdeal)
    model23=SAFTVRMie([species23]; idealmodel = JobackIdeal)
    model24=SAFTVRMie([species24]; idealmodel = JobackIdeal)
    model25=SAFTVRMie([species25]; idealmodel = JobackIdeal)
    model26=SAFTVRMie([species26]; idealmodel = JobackIdeal)
    model27=SAFTVRMie([species27]; idealmodel = JobackIdeal)
    model28=SAFTVRMie([species28]; idealmodel = JobackIdeal)
    model29=SAFTVRMie([species29]; idealmodel = JobackIdeal)
    model30=SAFTVRMie([species30]; idealmodel = JobackIdeal)
    model31=SAFTVRMie([species31]; idealmodel = JobackIdeal)
    model32=SAFTVRMie([species32]; idealmodel = JobackIdeal)
    model33=SAFTVRMie([species33]; idealmodel = JobackIdeal)

    models = [model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12,model13,model14,model15,model16,model17,model18,model19,model20,model21,model22,model23,model24,model25,model26,model27,model28,model29,model30,model31,model32,model33]

    n_models = length(models) # number of models evaluated
#

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
        append!(T,[range(min_exp_T,max_exp_T,length_T)])   
        s_s = speed_of_sound.(models[i], pressure, T[i])
        append!(model_msound,[[s_s[i][1] for i ∈ 1:length_T]])
    end
#

# PLOT sites
    # https://matplotlib.org/stable/api/markers_api.html
    # https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.legend.html
    # https://matplotlib.org/stable/gallery/lines_bars_and_markers/linestyles.html
    # https://matplotlib.org/stable/gallery/color/named_colors.html

# PLOT CnmimSCN
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL    
    PyPlot.plot(exp_T[1],exp_msound[1],label="[C₂mim][SCN]",linestyle="",marker="^",color="black")
    PyPlot.plot(exp_T[2],exp_msound[2],label="[C₄mim][SCN]",linestyle="",marker="s",color="royalblue")
    PyPlot.plot(exp_T[3],exp_msound[3],label="[C₆mim][SCN]",linestyle="",marker="o",color="hotpink")
# PLOT MODEL
    PyPlot.plot(T[1],model_msound[1],label="",linestyle="dotted",color="black")
    PyPlot.plot(T[2],model_msound[2],label="",linestyle="dotted",color="royalblue")
    PyPlot.plot(T[3],model_msound[3],label="",linestyle="dotted",color="hotpink")
    #
    PyPlot.plot(T[12],model_msound[12],label="",linestyle="dashed",color="black")
    PyPlot.plot(T[13],model_msound[13],label="",linestyle="dashed",color="royalblue")
    PyPlot.plot(T[14],model_msound[14],label="",linestyle="dashed",color="hotpink")
    #
    PyPlot.plot(T[23],model_msound[23],label="",linestyle="solid",color="black")
    PyPlot.plot(T[24],model_msound[24],label="",linestyle="solid",color="royalblue")
    PyPlot.plot(T[25],model_msound[25],label="",linestyle="solid",color="hotpink")
# PLOT AXES
    PyPlot.legend(loc="lower left",frameon=false,fontsize=16,ncol=1)
    PyPlot.xlabel("Temperature (K)",fontsize=16)
    PyPlot.ylabel("Speed of sound (m/s)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    PyPlot.ylim([1310,1890])
    display(PyPlot.gcf())

#
# PLOT CnmimTfO
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL
    PyPlot.plot(exp_T[4],exp_msound[4],label="[C₂mim][TfO]",linestyle="",marker="^",color="black")
    PyPlot.plot(exp_T[5],exp_msound[5],label="[C₄mim][TfO]",linestyle="",marker="s",color="royalblue")
# PLOT MODEL
    PyPlot.plot(T[4],model_msound[4],label="",linestyle="dotted",color="black")
    PyPlot.plot(T[5],model_msound[5],label="",linestyle="dotted",color="royalblue")
    #
    PyPlot.plot(T[15],model_msound[15],label="",linestyle="dashed",color="black")
    PyPlot.plot(T[16],model_msound[16],label="",linestyle="dashed",color="royalblue")
    #
    PyPlot.plot(T[26],model_msound[26],label="",linestyle="solid",color="black")
    PyPlot.plot(T[27],model_msound[27],label="",linestyle="solid",color="royalblue")
# PLOT AXES
    PyPlot.legend(loc="lower left",frameon=false,fontsize=16,ncol=1)
    PyPlot.xlabel("Temperature (K)",fontsize=16)
    PyPlot.ylabel("Speed of sound (m/s)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    PyPlot.ylim([1210,1590])
display(PyPlot.gcf())
#

# PLOT CnmimTf2N
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
# PLOT EXPERIMENTAL   
    # PyPlot.plot(exp_T[7],exp_msound[7],label="[C₂mim][Tf₂N]",linestyle="",marker="^",color="black")
    # PyPlot.plot(exp_T[8],exp_msound[8],label="[C₄mim][Tf₂N]",linestyle="",marker="s",color="royalblue")
    # PyPlot.plot(exp_T[9],exp_msound[9],label="[C₅mim][Tf₂N]",linestyle="",marker="o",color="hotpink")
    PyPlot.plot(exp_T[10],exp_msound[10],label="[C₆mim][Tf₂N]",linestyle="",marker="^",color="black")
    PyPlot.plot(exp_T[11],exp_msound[11],label="[C₈mim][Tf₂N]",linestyle="",marker="s",color="royalblue")
# PLOT MODEL
    # PyPlot.plot(T[7],model_msound[7],label="",linestyle="dotted",color="black")
    # PyPlot.plot(T[8],model_msound[8],label="",linestyle="dotted",color="royalblue")
    # PyPlot.plot(T[9],model_msound[9],label="",linestyle="dotted",color="hotpink")
    PyPlot.plot(T[10],model_msound[10],label="",linestyle="dotted",color="black")
    PyPlot.plot(T[11],model_msound[11],label="",linestyle="dotted",color="royalblue")
    #
    # PyPlot.plot(T[18],model_msound[18],label="",linestyle="dashed",color="black")
    # PyPlot.plot(T[19],model_msound[19],label="",linestyle="dashed",color="royalblue")
    # PyPlot.plot(T[20],model_msound[20],label="",linestyle="dashed",color="hotpink")
    PyPlot.plot(T[21],model_msound[21],label="",linestyle="dashed",color="black")
    PyPlot.plot(T[22],model_msound[22],label="",linestyle="dashed",color="royalblue")
    #
    # PyPlot.plot(T[29],model_msound[29],label="",linestyle="solid",color="black")
    # PyPlot.plot(T[30],model_msound[30],label="",linestyle="solid",color="royalblue")
    # PyPlot.plot(T[31],model_msound[31],label="",linestyle="solid",color="hotpink")
    PyPlot.plot(T[32],model_msound[32],label="",linestyle="solid",color="black")
    PyPlot.plot(T[33],model_msound[33],label="",linestyle="solid",color="royalblue")
# PLOT AXES
    PyPlot.legend(loc="lower left",frameon=false,fontsize=16,ncol=1)
    PyPlot.xlabel("Temperature (K)",fontsize=16)
    PyPlot.ylabel("Speed of sound (m/s)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    PyPlot.ylim([1060,1410])
display(PyPlot.gcf())
#