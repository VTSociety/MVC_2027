# IEEE VTS Motor Vehicle Challenge 2027 (MVC2027)
Repository of the 2027 IEEE VTS Motor Vehicle Challenge (MVC): **"Management of Energy Efficiency and Safety Operation for Multi-Actuated Ground Vehicles on DWPT Road"**. 
<img width="1536" height="1024" alt="img_flyer" src="https://github.com/user-attachments/assets/a4beb9bc-bde7-4678-9b4c-017252d9bcb4" />

## Introduction

The transportation sector is undergoing a fundamental transformation driven by the urgent need to reduce carbon emissions and develop sustainable urban mobility systems. Emerging technologies such as autonomous driving & motion control, optimal energy management & operation management, and dynamic wireless power transfer are shaping the future of mobility. The development and integration of these systems demand not only technological innovation but also a transdisciplinary approach combining expertise from electrical, automotive, control, mechanical, material engineering, etc.
<img width="1224" height="446" alt="image" src="https://github.com/user-attachments/assets/261bc524-986b-43a4-94ca-3bb2c6d17fd1" />

By sharing the aforementioned challenges, the topic proposed for the IEEE VTS Motor Vehicle Challenge 2027 (MVC2027) is to promote the understanding of future e-mobility systems and to emphasize the necessity of addressing their energy-related issues through a trans-disciplinary approach. To this end, MVC2027 provides participants with a simulator that accurately captures the dynamics of an in-wheel-motor vehicle developed and used at the University of Tokyo. The vehicle is assumed to operate autonomously on roads installed with a dynamic wireless power transfer (DWPT) infrastructure. Under realistic conditions, the vehicle is subjected to abrupt variations in road friction due to weather changes, as well as unpredictable disturbances such as strong lateral wind. 

Participants are therefore invited to develop an integrated strategy that coordinates **motor torque distribution**, **d-axis current control**, and **front steering angle**. The proposed strategy is expected to simultaneously achieve multiple objectives, including: 
1. improving **drivetrain efficiency** through the minimization of energy consumption;
2. ensuring **safe traction** by regulating wheel slip ratios;
3. enhancing **infrastructure utilization** by maximizing the energy received from DWPT; and
4. improving **driving comfort** by minimizing deviations in lateral acceleration.

## Team registration
Registration form will be available soon.

## Submission of proposals
Submission form will be available soon.

## Rules and instructions
 
Important rules that the submitted proposals must satisfy for being considered valid in this competition:

- The MATLAB/Simulink version used for the submitted files must be **R2022b**.
- Participants are allowed to modify only the `meso_para.m` script and the “Energy Management & Motion Control Strategy” block provided in the simulation file.
- All parameters provided in `sim_para.m`, as well as all sensor measurements available from the output of the “Vehicle Dynamics Model” block, may be used to develop the control strategy.
- All other scripts and simulation blocks must not be modified. Any modifications made to scripts other than `meso_para.m` or to subsystems other than “Energy Management & Motion Control Strategy” will be discarded during the evaluation.
- The final score will be calculated as the average of the scores obtained using the example driving cycle and a secret driving cycle.

Remark:
- Please take notice of the [Discussion board](https://github.com/VTSociety/MVC_2027/discussions/categories/q-a) for Q&A. Start a new discussion if you can't find an answer to your issue.

## What has to be uploaded for evaluation

In order to evaluate each proposal, the teams must submit in the form the following files:
- **Simulation file**: `MVC27_Sim.slx` must be renamed as `nameTeam_numProp_MVC27_Sim.slx` where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., `teamABC_prop1_MVC27_sim.slx`). 
- **Strategy .m file**: `meso_para.m` must be renamed as `nameTeam_numProp_meso_para.m` where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., `teamABC_prop1_meso_para.m`). 
- **ZIP file**: Backup simulation package of the proposed solution. Create a ZIP file including the following files: `main.m`, `sim_para.m`, `nameTeam_numProp_meso_para.m`, `driving_condition.m`, `LambdaMethod.m`, `sim_result_plot.m`, `scoring.m`, `nameTeam_numProp_MVC27_Sim.slx`. 
  - The score text file may also be included.
  - Participants can also include a file that briefly explains their idea, and any instruction for the organizers to reproduce and evaluate the proposed strategy.
  - Rename the ZIP file as `nameTeam_numProp_MVC27.zip`.
  - Please note the ZIP file is only a backup. Evaluation will mainly be based on the individual submitted files.

*Please avoid spaces and special characters in all file names.*

## Bibliography

Bibliography and related material is included in the [MATERIAL](https://github.com/VTSociety/MVC_2027/tree/main/MATERIAL) folder.

## License
All files of the repository "MVC_2027" are intended solely for the aim of the Motor Vehicle Challenge competition organized within the IEEE VTS Society. The Authors declined all responsibilities for usage outside this context. 

Copyright © 2025-2026. The code is released under the [CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/legalcode). Link to [short summary of CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/). For attribution see also [license file](LICENSE.md).
