print(@__FILE__)
print("\n")
# Cp AARD calculation
# bs04

# PACKAGES
    using Clapeyron # https://github.com/ClapeyronThermo/Clapeyron.jl
    using CSV
    using DataFrames
    using Statistics
    using LaTeXStrings
    using PyCall
    import PyPlot

# INPUT
    species1 = "C2MIMTF2N_2B"
    species2 = "C5MIMTF2N_2B"
    species3 = "C6MIMTF2N_2B"
    species4 = "C8MIMTF2N_2B"
    pressure = 101.325E+03 # Pa

# GENERATE MODELS
    model1 = SAFTVRMie([species1]; idealmodel = JobackIdeal)
    model1i = JobackIdeal([species1])
    model2 = SAFTVRMie([species2]; idealmodel = JobackIdeal)
    model2i = JobackIdeal([species2])
    model3 = SAFTVRMie([species3]; idealmodel = JobackIdeal)
    model3i = JobackIdeal([species3])
    model4 = SAFTVRMie([species4]; idealmodel = JobackIdeal)
    model4i = JobackIdeal([species4])

# EXPERIMENTAL DATA PATH
    temperature_begin = 270
    temperature_end = 423
    temperature_points = temperature_end - temperature_begin
    exp_temperature = range(temperature_begin,temperature_end,temperature_points)

# OBTAIN Cp with 'isobaric_heat_capacity' method
    model_Cp_1 = isobaric_heat_capacity.(model1,pressure,exp_temperature) # calculate Cp at 'pressure' and 'exp_temperature' using 'model1'
    model_Cp_ideal_1 = isobaric_heat_capacity.(model1i,pressure,exp_temperature)
    Cp_comparison_1 = 100 * (model_Cp_ideal_1./model_Cp_1)

    model_Cp_2 = isobaric_heat_capacity.(model2,pressure,exp_temperature)
    model_Cp_ideal_2 = isobaric_heat_capacity.(model2i,pressure,exp_temperature)
    Cp_comparison_2 = 100 * (model_Cp_ideal_2./model_Cp_2)

    model_Cp_3 = isobaric_heat_capacity.(model3,pressure,exp_temperature)
    model_Cp_ideal_3 = isobaric_heat_capacity.(model3i,pressure,exp_temperature)
    Cp_comparison_3 = 100 * (model_Cp_ideal_3./model_Cp_3)

    model_Cp_4 = isobaric_heat_capacity.(model4,pressure,exp_temperature)
    model_Cp_ideal_4 = isobaric_heat_capacity.(model4i,pressure,exp_temperature)
    Cp_comparison_4 = 100 * (model_Cp_ideal_4./model_Cp_4)

# Cp,ideal / Cp
    # Cp_comparison = 100 * (model_Cp_ideal./model_Cp)
    # print("Cp,ideal/Cp = ",Cp_comparison)
    # print("\n")
    # mean_Cp_comparison = mean(Cp_comparison)
    # print(species1," %Cp,ideal/Cp (avg) = ",mean_Cp_comparison)
    # print("\n")

# PLOT
    PyPlot.clf()
    PyPlot.rc("font", family="times new roman")
    PyPlot.figure(dpi=311)
    # PLOT MODEL
    PyPlot.plot(exp_temperature,Cp_comparison_1,label="[C₂mim][Tf₂N]",linestyle="dashed",color="black")
    PyPlot.plot(exp_temperature,Cp_comparison_2,label="[C₅mim][Tf₂N]",linestyle="dashed",color="royalblue")
    PyPlot.plot(exp_temperature,Cp_comparison_3,label="[C₆mim][Tf₂N]",linestyle="dashed",color="hotpink")
    PyPlot.plot(exp_temperature,Cp_comparison_4,label="[C₈mim][Tf₂N]",linestyle="dashed",color="forestgreen")
    # PLOT AXES
    PyPlot.legend(loc="best",frameon=false,fontsize=16)
    PyPlot.text(270,78, "2B association scheme", fontsize=16)
    PyPlot.xlabel("Temperature (K)",fontsize=16)
    # PyPlot.ylabel("Cpid/Cp (%)",fontsize=16)
    PyPlot.ylabel("C"*L"\rm{_p}"*L"\rm{^i}"*L"\rm{^d}"*"/C"*L"\rm{_p}"*" (%)",fontsize=16)
    PyPlot.xticks(fontsize=12)
    PyPlot.yticks(fontsize=12)
    # PyPlot.xlim([rho_end,rho_begin])
    # PyPlot.ylim([T_begin,T_end])
    # PyPlot.xlim([model_Cp[1][end],model_Cp[1][begin]])
    # PyPlot.ylim([T[1][begin],T[1][end]])
    # PyPlot.ylim([500,2000])
    display(PyPlot.gcf())

# quick ctrl+h - C5MIMTF2N