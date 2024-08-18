print(@__FILE__)
print("\n")
# ALPHA (Thermal expansion coefficient, isobaric expansivity in Clapeyron.jl, isobaric coefficient of volume expansion in ILThermo)

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
species_1N = "C2MIMTF2N_NA"
species_1B = "C2MIMTF2N_2B"
species_1C = "C2MIMTF2N" # 4C
species_2N = "C4MIMTF2N_NA"
species_2B = "C4MIMTF2N_2B"
species_2C = "C4MIMTF2N" # 4C
species_3N = "C6MIMTF2N_NA"
species_3B = "C6MIMTF2N_2B"
species_3C = "C6MIMTF2N" # 4C

T2 = 348.15 # K

####################
### EXPERIMENTAL ###
####################
path_x = ["C:/Users/cleiton/My Drive/usp-brainstorm/bs04/csv/alpha/PT2.csv"]
path_y = ["C:/Users/cleiton/My Drive/usp-brainstorm/bs04/csv/alpha/alphaT2.csv"]
# path_x = ["C:/Users/clsobe/My Drive/usp-brainstorm/bs04/csv/alpha/PT2.csv"]
# path_y = ["C:/Users/clsobe/My Drive/usp-brainstorm/bs04/csv/alpha/alphaT2.csv"]

expdata_x = CSV.read(path_x,DataFrame) # Pa
expdata_y = CSV.read(path_y,DataFrame) # K⁻¹

x1 = expdata_x[:,1]
x2 = x3 = PT2 = x1

y1 = expdata_y[:,1] # C2MIMTF2N
y2 = expdata_y[:,2] # C4MIMTF2N
y3 = expdata_y[:,3] # C6MIMTF2N

################
### MODELING ###
################
model1N=SAFTVRMie([species_1N])
model1B=SAFTVRMie([species_1B])
model1C=SAFTVRMie([species_1C])
model2N=SAFTVRMie([species_2N])
model2B=SAFTVRMie([species_2B])
model2C=SAFTVRMie([species_2C])
model3N=SAFTVRMie([species_3N])
model3B=SAFTVRMie([species_3B])
model3C=SAFTVRMie([species_3C])

alpha1N=isobaric_expansivity.(model1N, PT2, T2; phase=:liquid)
alpha1B=isobaric_expansivity.(model1B, PT2, T2; phase=:liquid)
alpha1C=isobaric_expansivity.(model1C, PT2, T2; phase=:liquid)
alpha2N=isobaric_expansivity.(model2N, PT2, T2; phase=:liquid)
alpha2B=isobaric_expansivity.(model2B, PT2, T2; phase=:liquid)
alpha2C=isobaric_expansivity.(model2C, PT2, T2; phase=:liquid)
alpha3N=isobaric_expansivity.(model3N, PT2, T2; phase=:liquid)
alpha3B=isobaric_expansivity.(model3B, PT2, T2; phase=:liquid)
alpha3C=isobaric_expansivity.(model3C, PT2, T2; phase=:liquid)

################
### PLOTTING ###
################
PyPlot.clf()
PyPlot.rc("font", family="times new roman")
# PyPlot.figure(figsize=(5,20))
PyPlot.figure(dpi=311)
# PyPlot.figure(dpi=420)

PyPlot.plot(PT2*1e-6,y1*1e3,label="[C₂mim][Tf₂N]",linestyle="",marker="^",color="black")
PyPlot.plot(PT2*1e-6,y2*1e3,label="[C₄mim][Tf₂N]",linestyle="",marker="s",color="royalblue")
PyPlot.plot(PT2*1e-6,y3*1e3,label="[C₆mim][Tf₂N]",linestyle="",marker="o",color="hotpink")

PyPlot.plot(PT2*1e-6,alpha1N*1e3,label="",linestyle="dotted",color="black")
PyPlot.plot(PT2*1e-6,alpha1B*1e3,label="",linestyle="dotted",color="royalblue")
PyPlot.plot(PT2*1e-6,alpha1C*1e3,label="",linestyle="dotted",color="hotpink")

PyPlot.plot(PT2*1e-6,alpha2N*1e3,label="",linestyle="dashed",color="black")
PyPlot.plot(PT2*1e-6,alpha2B*1e3,label="",linestyle="dashed",color="royalblue")
PyPlot.plot(PT2*1e-6,alpha2C*1e3,label="",linestyle="dashed",color="hotpink")

PyPlot.plot(PT2*1e-6,alpha3N*1e3,label="",linestyle="solid",color="black")
PyPlot.plot(PT2*1e-6,alpha3B*1e3,label="",linestyle="solid",color="royalblue")
PyPlot.plot(PT2*1e-6,alpha3C*1e3,label="",linestyle="solid",color="hotpink")

PyPlot.legend(loc="best",frameon=false,fontsize=16,ncol=1)
PyPlot.text(10,0.54, "348.15 K", fontsize=14)
PyPlot.xlabel("Pressure (MPa)",fontsize=16)
# PyPlot.ylabel("α (1×10³ K⁻¹)",fontsize=16)
PyPlot.ylabel("α"*L"\rm{_p}"*" (1×10³ K⁻¹)",fontsize=16)
PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)
PyPlot.xlim(PT2[1]*1e-6,PT2[end]*1e-6)
PyPlot.yticks(collect(0.52:0.02:0.66))
PyPlot.ylim(0.52,0.66)
display(PyPlot.gcf())

################################################
################################################
################################################
################################################
################################################
################################################
################################################

PyPlot.clf()
PyPlot.rc("font", family="times new roman")
PyPlot.figure(dpi=311)

PyPlot.plot(PT2*1e-6,y1*1e3,label="[C₂mim][Tf₂N]",linestyle="",marker="^",color="black")

PyPlot.plot(PT2*1e-6,alpha1N*1e3,label="",linestyle="dotted",color="black")

PyPlot.plot(PT2*1e-6,alpha2N*1e3,label="",linestyle="dashed",color="black")

PyPlot.plot(PT2*1e-6,alpha3N*1e3,label="",linestyle="solid",color="black")

PyPlot.legend(loc="best",frameon=false,fontsize=16,ncol=1)
PyPlot.text(10,0.54, "348.15 K", fontsize=14)
PyPlot.xlabel("Pressure (MPa)",fontsize=16)
# PyPlot.ylabel("α (1×10³ K⁻¹)",fontsize=16)
PyPlot.ylabel("α"*L"\rm{_p}"*" (1×10³ K⁻¹)",fontsize=16)
PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)
PyPlot.xlim(PT2[1]*1e-6,PT2[end]*1e-6)
PyPlot.yticks(collect(0.52:0.02:0.66))
PyPlot.ylim(0.52,0.66)
display(PyPlot.gcf())

################################################
################################################
################################################
################################################
################################################
################################################
################################################

PyPlot.clf()
PyPlot.rc("font", family="times new roman")
PyPlot.figure(dpi=311)

PyPlot.plot(PT2*1e-6,y2*1e3,label="[C₄mim][Tf₂N]",linestyle="",marker="^",color="black")

PyPlot.plot(PT2*1e-6,alpha1B*1e3,label="",linestyle="dotted",color="black")

PyPlot.plot(PT2*1e-6,alpha2B*1e3,label="",linestyle="dashed",color="black")

PyPlot.plot(PT2*1e-6,alpha3B*1e3,label="",linestyle="solid",color="black")

PyPlot.legend(loc="best",frameon=false,fontsize=16,ncol=1)
PyPlot.text(10,0.54, "348.15 K", fontsize=14)
PyPlot.xlabel("Pressure (MPa)",fontsize=16)
# PyPlot.ylabel("α (1×10³ K⁻¹)",fontsize=16)
PyPlot.ylabel("α"*L"\rm{_p}"*" (1×10³ K⁻¹)",fontsize=16)
PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)
PyPlot.xlim(PT2[1]*1e-6,PT2[end]*1e-6)
PyPlot.yticks(collect(0.52:0.02:0.66))
PyPlot.ylim(0.52,0.66)
display(PyPlot.gcf())

################################################
################################################
################################################
################################################
################################################
################################################
################################################

PyPlot.clf()
PyPlot.rc("font", family="times new roman")
PyPlot.figure(dpi=311)

PyPlot.plot(PT2*1e-6,y3*1e3,label="[C₆mim][Tf₂N]",linestyle="",marker="^",color="black")

PyPlot.plot(PT2*1e-6,alpha1C*1e3,label="",linestyle="dotted",color="black")

PyPlot.plot(PT2*1e-6,alpha2C*1e3,label="",linestyle="dashed",color="black")

PyPlot.plot(PT2*1e-6,alpha3C*1e3,label="",linestyle="solid",color="black")

PyPlot.legend(loc="best",frameon=false,fontsize=16,ncol=1)
PyPlot.text(10,0.54, "348.15 K", fontsize=14)
PyPlot.xlabel("Pressure (MPa)",fontsize=16)
# PyPlot.ylabel("α (1×10³ K⁻¹)",fontsize=16)
PyPlot.ylabel("α"*L"\rm{_p}"*" (1×10³ K⁻¹)",fontsize=16)
PyPlot.xticks(fontsize=12)
PyPlot.yticks(fontsize=12)
PyPlot.xlim(PT2[1]*1e-6,PT2[end]*1e-6)
PyPlot.yticks(collect(0.52:0.02:0.66))
PyPlot.ylim(0.52,0.66)
display(PyPlot.gcf())