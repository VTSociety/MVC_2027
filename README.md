# IEEE VTS Motor Vehicle Challenge 2027

Repository of the 2027 IEEE VTS Motor Vehicle Challenge: **"Management of Energy Efficiency and Safety Operation for Multi-Actuated Ground Vehicles on DWPT Road"**. 

**[Official Website](https://vtsociety.org/event/workshop/ieee-vts-motor-vehicles-challenge-2027#description)**

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

## Important dates and submission forms
- Registration deadline: 31 January 2027.
  - Register your team for the challenge using the [Registration form](https://docs.google.com/forms/d/e/1FAIpQLScn9QM5dTbPJO58kUCpS6MpwM0aLW2bU7g9Atntza7pp8_2uQ/viewform).
- Submission deadline: 1 March 2027
  - Submit your proposals using the [Submission form](https://docs.google.com/forms/d/e/1FAIpQLSdaAZOpiFS4j9ZSh1LC5OPYZo41tUQKE3v68uK8hWsC88eRkA/viewform).
- Results: 31 March 2027

## Rules and instructions 
Important rules that the submitted proposals must satisfy for being considered valid in this competition:

1. The MATLAB/Simulink version used for the submitted files must be **R2022b**.
2. Participants are allowed to modify only the `meso_para.m` script and the “Energy Management & Motion Control Strategy” block provided in the simulation file.
3. All parameters provided in `sim_para.m`, as well as all sensor measurements available from the output of the “Vehicle Dynamics Model” block, may be used to develop the control strategy.
4. All other scripts and simulation blocks must not be modified. Any modifications made to scripts other than `meso_para.m` or to subsystems other than “Energy Management & Motion Control Strategy” will be discarded during the evaluation.
5. The final score will be calculated as the average of the scores obtained using the example driving cycle and a secret driving cycle.
6. A proposed strategy will be disqualified if the vehicle fails to complete either driving cycle (e.g., the vehicle stops before reaching the end of the driving cycle), or if the lateral position of the vehicle exceeds 5 m at any time during the simulation.

Remark:
- Please take notice of the [Discussion board](https://github.com/VTSociety/MVC_2027/discussions/categories/q-a) for Q&A. Start a new discussion if you can't find an answer to your issue.


## What has to be uploaded for evaluation

In order to evaluate each proposal, the teams must submit in the [submission form](https://docs.google.com/forms/d/e/1FAIpQLSdaAZOpiFS4j9ZSh1LC5OPYZo41tUQKE3v68uK8hWsC88eRkA/viewform) the following files:
- **Simulation file**: `MVC27_Sim.slx` must be renamed as `nameTeam_numProp_MVC27_Sim.slx` where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., `teamABC_prop1_MVC27_sim.slx`). 
- **Strategy .m file**: `meso_para.m` must be renamed as `nameTeam_numProp_meso_para.m` where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., `teamABC_prop1_meso_para.m`). 
- **ZIP file**: Backup simulation package of the proposed solution. Create a ZIP file including the following files: `main.m`, `sim_para.m`, `nameTeam_numProp_meso_para.m`, `driving_condition.m`, `LambdaMethod.m`, `sim_result_plot.m`, `scoring.m`, `nameTeam_numProp_MVC27_Sim.slx`. 
  - The score text file may also be included.
  - Participants can also include a file that briefly explains their idea, and any instruction for the organizers to reproduce and evaluate the proposed strategy.
  - Rename the ZIP file as `nameTeam_numProp_MVC27.zip`.
  - Please note the ZIP file is only a backup. Evaluation will mainly be based on the individual submitted files.

*Please avoid spaces and special characters in all file names.*

## FAQ
<details>
<summary><b>1. Is it permissible to reduce the total torque?</b></summary>

Yes, participants are allowed to reduce the total driving torque, i.e.  $`\sum T^*_i \neq T^*_{all}`$.  

For instance, participant might develop a *Torque reduction algorithm* that detects when the vehicle enters the low friction region and adjusts $T^*_{all}$ to $`\tilde{T}^*_{all}`$. Then, $`\tilde{T}^*_{all}`$ is distributed among four wheels using torque distribution ratios $k_i$.  

<img width="1476" height="878" alt="image" src="https://github.com/user-attachments/assets/f506d128-c775-4b99-a2e2-2fb60c2ce81f" />


</details>

<details>
<summary><b>2. Will the location of the DWPT zone remain the same in the secret scoring cycle?</b></summary>
  
Not necessarily. The location of the DWPT zone in the secret test cycle may differ from that in the example driving cycle. Participants should therefore not assume that the DWPT zone will always be located between 500 m and 1500 m.
</details>

<details>
<summary><b>3. Will the simulation time and the total distance remain the same in the secret scoring cycle?</b></summary>
  
The exact simulation duration `Sim.Tsim` and the length of the scoring cycle will remain confidential. However, it will correspond to the time required for an electric vehicle to travel from the University of Tokyo's Kashiwa Campus to Kashiwanoha-campus Station in Kashiwa City, Chiba Prefecture, Japan.
</details>

<details>
<summary><b>4. Is it allowed to use an additional signal in the proposed strategy, beyond the 12 sensor signals?</b></summary>
  
No, participants are allowed to use only the 12 provided sensor signals to develop their control algorithms. 

However, participants are encouraged to develop estimation algorithms using these limited sensor signals to estimate unknown variables and conditions, such as the friction coefficient, disturbances caused by lateral wind forces, or vertical loads at each wheel.
</details>
 

## Bibliography

Bibliography and related material is included in the [MATERIAL](https://github.com/VTSociety/MVC_2027/tree/main/MATERIAL) folder.

## License
All files of the repository "MVC_2027" are intended solely for the aim of the Motor Vehicle Challenge competition organized within the IEEE VTS Society. The Authors declined all responsibilities for usage outside this context. 

Copyright © 2025-2026. The code is released under the [CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/legalcode). Link to [short summary of CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/). For attribution see also [license file](LICENSE.md).
