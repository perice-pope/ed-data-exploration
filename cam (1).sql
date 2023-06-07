create schema if not exists cam;

alter schema cam owner to postgres;

create table if not exists cam.type_of_subsidy_descriptor
(
	type_of_subsidy_id integer 
		primary key not null,
	type_of_subsidy text,
	update_user varchar(100),
	update_dt timestamp
);

create table if not exists cam.account_household
(
	account_id integer 
		not null primary key,
	account_name text,
	data_sharing_consent_signed boolean,
	data_sharing_consent_date_id integer 
		references common.calendar_date,
	hh_data_sharing_consent_retracted boolean default false,
	billing_street text,
	billing_city text,
	billing_state_province text,
	billing_zip_postal_code text,
	homeless boolean,
	renting boolean,
	paying_a_mortgage boolean, 
	subsidized boolean,
	type_of_subsidy_id integer 
		references cam.type_of_subsidy_descriptor,
	moved_to_current_address_date_id integer 
		references common.calendar_date
);

alter table cam.account_household owner to postgres;

create table if not exists cam.contact 
(
    contact_id integer not null primary key,
    account_id integer 
		references cam.account_household,
	person_id integer 
		references dt.person,
    served_in_us_military_id integer
		references common.served_in_us_military_descriptor,
    household_status_id integer
		references common.household_status_descriptor,
    hh_member_type_id integer
		references common.hh_member_type_descriptor,
    relationship_to_head_of_household_id integer
		references common.relationship_to_hh_descriptor,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.contact owner to postgres;

create table if not exists cam.contact_races (
    contact_id integer 
		references cam.contact,
	race_id integer 
		references common.race_descriptor,
    primary key (contact_id, race_id)
);

alter table cam.contact_races owner to postgres;


create table if not exists cam.social_determinant_descriptor
(
	social_determinant_id integer not null
		primary key,
	social_determinant text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.social_determinant_descriptor owner to postgres;


create table if not exists cam.external_referral
(
	record_id integer not null
		primary key,
	external_referral_no serial,
	account_household_id integer
		references cam.account_household,
	agency_referral_1 integer
		references cam.account_household,
	agency_referral_2 integer
		references cam.account_household,
	agency_referral_3 integer
		references cam.account_household,
	agency_referral_4 integer
		references cam.account_household,
	agency_referral_5 integer
		references cam.account_household,
	account_name_1 text, 
	account_name_2 text,
	account_name_3 text,
	account_name_4 text,
	account_name_5 text,
	agency_1_social_determinant_id integer
		references cam.social_determinant_descriptor,
	agency_2_social_determinant_id integer
		references cam.social_determinant_descriptor,
	agency_3_social_determinant_id integer
		references cam.social_determinant_descriptor,
	agency_4_social_determinant_id integer
		references cam.social_determinant_descriptor,
	agency_5_social_determinant_id integer
		references cam.social_determinant_descriptor,
	agency_mini_pantry boolean,
	cip_referral boolean,
	ramp_clt_referral boolean,
	furniture_appliance_store boolean,
	free_store boolean
);

alter table cam.external_referral owner to postgres;

create table if not exists cam.emergency_status_descriptor
(
	emergency_status_id integer not null
		primary key,
	emergency_status text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.emergency_status_descriptor owner to postgres;

create table if not exists cam.emergency_type_descriptor
(
	emergency_type_id integer not null
		primary key,
	emergency_type text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.emergency_type_descriptor owner to postgres;

create table if not exists cam.financial_emergency
(
	record_id integer not null
		primary key,
	financial_emergency_no serial,
	service_request_date_id integer
		references common.calendar_date,
	emergency_type_id integer
		references cam.emergency_type_descriptor,
	emergency_status_id integer
		references cam.emergency_status_descriptor,
	rent_mortgage decimal(10,2),
	monthly_rent_mtg_amt decimal(10,2),
	rent_past_due decimal(10,2),
	late_fees decimal(10,2),
	total_rent_owed decimal(10,2),
	amount_to_hold_30_days_rent decimal(10,2),
	utility_mount_past_due decimal(10,2),
	amt_to_hold_30_days_utility decimal(10,2),
	ep_amt decimal(10,2),
	reconnection_fee decimal(10,2),
	deposit decimal(10,2),
	oil_kero_total decimal(10,2),
	total_owed decimal(10,2),
	amt_cust_must_pay_bef_agency_will_assist decimal(10,2)
);

alter table cam.financial_emergency owner to postgres;

create table if not exists cam.record_type_descriptor
(
	record_type_id integer not null
		primary key,
	record_type text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.record_type_descriptor owner to postgres;

create table if not exists cam.cause_emergency_descriptor
(
	cause_emergency_id integer not null
		primary key,
	cause_emergency text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.cause_emergency_descriptor owner to postgres;


create table if not exists cam.referring_partner_agency
(
	referring_partner_agency_id integer not null
		primary key,
	referring_partner_agency_name text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.referring_partner_agency owner to postgres;

create table if not exists cam.cause_of_crisis_descriptor
(
	cause_of_crisis_id integer not null
		primary key,
	cause_of_crisis text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.cause_of_crisis_descriptor owner to postgres;

create table if not exists cam.reason_for_homelessness_descriptor
(
	reason_for_homelessness_id integer not null
		primary key,
	reason_for_homelessness text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.reason_for_homelessness_descriptor owner to postgres;

create table if not exists cam.request_type_descriptor
(
	request_type_id integer not null
		primary key,
	request_type text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.request_type_descriptor owner to postgres;

create table if not exists cam.service_status_descriptor
(
	service_status_id integer not null
		primary key,
	service_status text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.service_status_descriptor owner to postgres;

create table if not exists cam.reason_for_denial_descriptor
(
	reason_for_denial_id integer not null
		primary key,
	reason_for_denial text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.reason_for_denial_descriptor owner to postgres;

create table if not exists cam.priority_emergency_type_descriptor
(
	priority_emergency_type_id integer not null
		primary key,
	priority_emergency_type text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.priority_emergency_type_descriptor owner to postgres;

create table if not exists cam.customer_requesting_assistance_descriptor
(
	customer_requesting_assistance_id integer not null
		primary key,
	customer_requesting_assistance text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.customer_requesting_assistance_descriptor owner to postgres;

create table if not exists cam.employment_situation_descriptor
(
	employment_situation_id integer not null
		primary key,
	employment_situation text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.employment_situation_descriptor owner to postgres;

create table if not exists cam.challenges_to_improving_situation_descriptor
(
	challenges_to_improving_situation_id integer not null
		primary key,
	challenges_to_improving_situation text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.challenges_to_improving_situation_descriptor owner to postgres;

create table if not exists cam.income_stability_descriptor
(
	income_stability_id integer not null
		primary key,
	income_stability text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.income_stability_descriptor owner to postgres;

create table if not exists cam.building_savings_with_current_income_descriptor
(
	building_savings_with_current_income_id integer not null
		primary key,
	building_savings_with_current_income text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.building_savings_with_current_income_descriptor owner to postgres;

create table if not exists cam.persona_descriptor
(
	persona_id integer not null
		primary key,
	persona text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.persona_descriptor owner to postgres;

create table if not exists cam.home_visit_completed_descriptor
(
	home_visit_completed_id integer not null
		primary key,
	home_visit_completed text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.home_visit_completed_descriptor owner to postgres;

create table if not exists cam.items_needed_descriptor
(
	items_needed_id integer not null
		primary key,
	items_needed text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.items_needed_descriptor owner to postgres;


create table if not exists cam.service_request
(
	record_id integer not null 
		primary key,
	record_type_id integer
		references cam.record_type_descriptor,
	service_request_date_id integer 
		references common.calendar_date,
	service_request_no serial,
	household_account_id integer 
		references cam.account_household,
	account_name_as_text text,
	customer_id integer 
		references cam.contact,
	household_size integer,
	request_type_id integer
		references cam.request_type_descriptor,
	service_status_id integer
		references cam.service_status_descriptor,
	number_of_children_2_16yrs smallint,
	number_of_children_infants smallint,
	number_of_men smallint,
	number_of_women smallint,
	referring_partner_agency_name_partner_account_id integer 
		references cam.referring_partner_agency,
	service_request_referring_partner_agency_id integer 
		references cam.referring_partner_agency,
	if_not_approved_reason_for_denial_id integer
		references cam.reason_for_denial_descriptor,
	priority_emergency_type_id integer
		references cam.priority_emergency_type_descriptor,
	disconnect_date integer 
		references common.calendar_date,
	court_date integer 
		references common.calendar_date,
	padlock_date integer 
		references common.calendar_date,
	current_employment_situation_id integer
		references cam.employment_situation_descriptor,
	challenges_to_improving_situation_id integer
		references  cam.challenges_to_improving_situation_descriptor,
	income_stability_id integer
		references cam.income_stability_descriptor,
	building_savings_with_current_income_id integer
		references cam.building_savings_with_current_income_descriptor,
	persona_id integer
		references cam.persona_descriptor,
	no_income boolean,
	hh_gross_ei_last_30 decimal(12,2),
	hh_net_ei_last_30 decimal(12,2),
	hh_ui_last_30 decimal(12,2),
	total_gross_hh_inc_last_30 decimal(12,2),
	total_net_hh_inc_last_30 decimal(12,2),
	total_average_monthly_expenses_last_30 decimal(12,2),
	total_expense_amount_next_30 decimal(12,2),
	hh_net_ei_for_next_30 decimal(12,2),
	isc_hh_ui_next_30 decimal(16,2),
	total_hh_net_income_next_30 decimal(16,2),
	cause_of_crisis_id integer
		references cam.cause_of_crisis_descriptor,
	please_describe_special_need text,
	reason_for_homelessness_id integer
		references cam.reason_for_homelessness_descriptor,
	reason_for_homelessness_other text,
	total_household_income decimal(8,2), 
	home_visit_completed_id integer
		references cam.home_visit_completed_descriptor,
	current_mecklenburg_county_resident boolean,
	cause_to_request_furniture_or_appliance text,
	items_needed_id integer
		references cam.items_needed_descriptor, 
	furniture_requested decimal(10,2),
	furniture_distributed decimal(10,2),
	clothing_received_men smallint,
	clothing_received_women smallint,
	clothing_received_child_2_16yrs smallint,
	clothing_received_child_infant smallint,
	received_winter_coat smallint,
	blankets_received smallint,
	total_number_clothing_items_for_hh integer,
	hh_items_received smallint
);

alter table cam.service_request owner to postgres;

create table if not exists cam.service_request_craw (
    record_id integer 
		references cam.service_request,
    customer_requesting_assistance_id integer 
		references cam.customer_requesting_assistance_descriptor,
    primary key (record_id, customer_requesting_assistance_id)
);

alter table cam.service_request_craw owner to postgres;


create table if not exists cam.food_voucher_descriptor
(
	food_voucher_id integer not null
		primary key,
	food_voucher text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.food_voucher_descriptor owner to postgres;

create table if not exists cam.case_notes_plan
(
	case_id integer not null primary key,
	service_request_id integer	
		references cam.service_request,
	case_plan_no serial,
	bus_pass_given boolean,
	number_of_bus_passes_given integer,
	food_given_from_pantry boolean,
	food_voucher_id integer
		references cam.food_voucher_descriptor ,
	food_voucher_amount decimal(10,2)
);

alter table cam.case_notes_plan owner to postgres;

create table if not exists cam.vendor_check
(
	record_id text not null
		primary key,
	financial_emergency_id integer
		references cam.financial_emergency,
	paid_to_vendor_name text,
	total_check_amount decimal(10,2)
);

alter table cam.vendor_check owner to postgres;

create table if not exists cam.pay_frequency_descriptor
(
	pay_frequency_id integer not null
		primary key,
	pay_frequency text,
	update_user varchar(100),
	update_dt timestamp
);

alter table cam.pay_frequency_descriptor owner to postgres;

create table if not exists cam.budget (
    record_id integer not null primary key,
    household_account_id integer
		references cam.account_household,
    customer_hh_member_id integer
		references cam.account_household,
    hourly_pay_rate decimal(7, 2),
    avg_no_of_hours_week smallint,
    is_anyone_self_employed boolean,
    pay_frequency_id integer
		references cam.pay_frequency_descriptor,
    starting_a_new_job boolean,
    stopped_working_last_30_days boolean,
    car_insurance decimal(8, 2),
    car_payments decimal(8, 2),
    cell_phone decimal(8, 2),
    child_sup_alimony decimal(8, 2),
    child_care decimal(8, 2),
    electric decimal(12, 2),
    food decimal(12, 2),
    gas decimal(12, 2),
    gasoline decimal(12, 2),
    oil_propane_kerosene decimal(12, 2),
    other_personal_exp decimal(12, 2),
    receives_food_stamps boolean,
    number_receiving_snap_benefits integer,
    monthly_food_stamp_benefit_amount decimal(16, 2),
    rent_mortgage decimal(8, 2),
    tv_internet_bundled decimal(12, 2),
    water decimal(12, 2),
    adopt_foster_care_amount decimal(10, 2),
    child_supp_amount decimal(10, 2),
    edu_supp_amount decimal(10, 2),
    ltd_amount decimal(10, 2),
    military_work_release_amt decimal(10, 2),
    retirement_amount decimal(10, 2),
    rev_mtg_amount decimal(10, 2),
    ssa_amount decimal(10, 2),
    ssi_amount decimal(10, 2),
    state_special_asst_amt decimal(10, 2),
    std_amount decimal(10, 2),
    uib_amount decimal(10, 2),
    utility_asst_amount decimal(10, 2),
    va_benefits_amount decimal(10, 2),
    wffa_tanf_amount decimal(10, 2),
    workers_comp_amount decimal(10, 2),
    other_income_amt decimal(10, 2)
);

alter table cam.budget owner to postgres;
