/* Edit the following line to reflect the full path to your CSV file */
%let csv_file = '/folders/myfolders/ART_EEG_2020/Recruitment_2020/Raw Data/ScreeningForADRDRese-RECPossiblyEligibleN_DATA_NOHDRS_2020-08-03_1013.csv';

proc format;
	value $redcap_repeat_instrument_ telephone_log='Telephone Log';
	value funnel_run_number_ 1='ARCHIVED_M2_1.0 Sleep Lab Epic Query Export_UP' 2='ARCHIVED_M2_1.1 Sleep Lab Epic Query Export_UP' 
		3='ARCHIVED_M2_2.0 Sleep Lab Patient Form Referral_UP' 6='ARCHIVED_M2_2.1 Sleep Lab Intake Form_UP' 
		11='ARCHIVED_M2_2.2_Sleep_Lab_Expedited_PreClinic_CPAP_UP' 12='ARCHIVED_M2_2.3_Sleep_Lab_Expedited_PreClinic_CPAP_UP Age >=60' 
		16='ARCHIVED_M2_2.4_EPIC_Intake_UP' 17='ARCHIVED_M2_2.5_EPIC_Intake_UP Age >= 60' 
		4='ARCHIVED_M2_3.0 Sleep Clinic Provider Direct Referral_UP' 13='M2_1.2 Sleep Lab Epic Query Export_UP Age >=60' 
		10='M2_1.3_Sleep_Lab_Query_Export_55-60_UP' 14='M2_1.4_Home_Sleep_Studies_UP' 
		25='M2_11.1 Community Flyers_UP' 18='M2_2.6_PennChart_55-60_UP' 
		19='M2_2.7_PennChart_gt60_UP' 20='M2_2.8_JU_Sleep_clinic' 
		29='M2_24.1 Brochures_UP' 28='M2_24.2_Cardiology Clinic_UP' 
		5='M2_4.0 Sleep Clinic Pre-identified Referral_UP' 15='M2_40.1_PennSeek_UP' 
		21='M2_50.1_MPeer2Peer_UP' 26='M2_50.2_Healthy Patterns Referrals_UP' 
		27='M2_50.3_Music, Sleep and Dementia Referrals_UP' 24='M2_7.0_CPAP nonadherent_UP' 
		22='M2_UP_6.0_ Clinical_PSG_Active File Recruitment' 23='UP_21.0_Geriatric Information Sheet 2 page_UP' 
		30='M2_9.0 Sleep Lab 2-page Information Sheet_UP' 31='M2_UP_14.1 Facebook' 
		32='M2_UP_14.2 Google Ad';
	value p_intake_elig_det_ 1='Intake Eligible (high priority)' 2='Intake Eligible (medium priority)' 
		3='Intake Eligible (low priority)' 4='Ineligible' 
		5='Pending  (PSG Pending)';
	value m2_screen_next_step_person_ 0='n/a' 1='Research coordinator' 
		2='Site PI' 3='Project Manager' 
		4='Other site co-investigator';
	value cognition_survey_ 1='Yes' 0='No';
	value cognition_survey2_ 1='Yes' 0='No';

	run;

data work.redcap; %let _EFIERR_ = 0;
infile &csv_file  delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=1 ;

	informat dyad_id $500. ;
	informat redcap_repeat_instrument $500. ;
	informat redcap_repeat_instance best32. ;
	informat funnel_run_number best32. ;
	informat date_last_updated yymmdd10. ;
	informat p_intake_elig_det best32. ;
	informat m2_staff_next_step_date yymmdd10. ;
	informat m2_screen_next_step_person best32. ;
	informat p_intake_ahi best32. ;
	informat psg_date yymmdd10. ;
	informat return_clinic_date yymmdd10. ;
	informat return_clinic_time time5. ;
	informat cognition_survey best32. ;
	informat cognition_survey2 best32. ;
	informat pat_letter_date yymmdd10. ;

	format dyad_id $500. ;
	format redcap_repeat_instrument $redcap_repeat_instrument_. ;
	format redcap_repeat_instance best12. ;
	format funnel_run_number best12. ;
	format date_last_updated yymmdd10. ;
	format p_intake_elig_det best12. ;
	format m2_staff_next_step_date yymmdd10. ;
	format m2_screen_next_step_person best12. ;
	format p_intake_ahi best12. ;
	format psg_date yymmdd10. ;
	format return_clinic_date yymmdd10. ;
	format return_clinic_time time5. ;
	format cognition_survey best12. ;
	format cognition_survey2 best12. ;
	format pat_letter_date yymmdd10. ;

input
	dyad_id $
	redcap_repeat_instrument $
	redcap_repeat_instance
	funnel_run_number
	date_last_updated
	p_intake_elig_det
	m2_staff_next_step_date
	m2_screen_next_step_person
	p_intake_ahi
	psg_date
	return_clinic_date
	return_clinic_time
	cognition_survey
	cognition_survey2
	pat_letter_date
;
if _ERROR_ then call symput('_EFIERR_',"1");
run;

proc contents;run;

data redcap;
	set redcap;
	label dyad_id='Dyad ID';
	label redcap_repeat_instrument='Repeat Instrument';
	label redcap_repeat_instance='Repeat Instance';
	label funnel_run_number='Funnel Run Number (Key variable)';
	label date_last_updated='Date Last Updated (Key variable)';
	label p_intake_elig_det='Intake Eligibility Determination (Key variable)';
	label m2_staff_next_step_date='Next Step Date (Key Variable)';
	label m2_screen_next_step_person='Next Step Person';
	label p_intake_ahi='Baseline Patient AHI (Key variable)';
	label psg_date='PSG Date (Key variable)';
	label return_clinic_date='Return Clinic Appointment Date';
	label return_clinic_time='Return Clinic Appointment Time';
	label cognition_survey='Does someone help you keep track of your appointments or medications? (Key variable)';
	label cognition_survey2='Do you have, or has someone told you you have problems with thinking and/or memory? (Key variable)';
	label pat_letter_date='Date Patient Letter Sent (Key variable)';
	format redcap_repeat_instrument redcap_repeat_instrument_.;
	format funnel_run_number funnel_run_number_.;
	format p_intake_elig_det p_intake_elig_det_.;
	format m2_screen_next_step_person m2_screen_next_step_person_.;
	format cognition_survey cognition_survey_.;
	format cognition_survey2 cognition_survey2_.;
run;

proc contents data=redcap;

run;