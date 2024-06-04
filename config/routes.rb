Rails.application.routes.draw do
  resources :clinics do
    collection do
      get 'doctor_schedule_clinic_table'
      get 'nurse_schedule_clinic_table'
      patch 'nurse_make_clinic_ongoing'
      get 'doctor_ongoing_clinic_table'
      patch 'doctor_complete_clinic'
      get 'clinic_by_patient_id'
    end
  end
  resources :tests do
    collection do
      get 'find_by_patient_id'
      get 'requested_tests'
      patch 'nurse_make_test_scheduled'
      get 'scheduled_tests'
      get 'doctor_pending_test'
      get 'find_by_test_id'
      patch 'nurse_make_test_finished'
      get 'test_by_patient_id'
    end
  end
  resources :references do
    collection do
      get 'find_by_reference_id'
      get 'find_by_patient_id'
      get 'find_by_doctor_id'
      get 'doctor_incoming_references'
    end
  end
  resources :treatment_records do
    collection do
      get 'find_by_patient_id'
      get 'find_by_nurse_id'
      patch 'nurse_confirm_treatment_record'
      get 'treatment_records_by_patient_id'
    end
  end
  resources :treatment_plans do
    collection do
      get 'find_by_treatment_id'
      get 'find_by_doctor_id'
      get 'find_by_patient_id'
      get 'find_by_diagnose_id'
      patch 'doctor_pause_treatment'
      patch 'doctor_resume_treatment'
      patch 'doctor_change_treatment_type'
    end
  end
  resources :diagnoses do
    collection do
      get 'find_by_diagnose_id'
      get 'find_by_patient_id'
      get 'find_by_doctor_id'
      patch 'doctor_change_category'
    end
  end
  resources :beds do
    collection do
      get 'get_available_beds_by_ward'
      patch 'admit_patient'
      patch 'discharge_patient'
    end
  end
  resources :appointments do
    collection do
      get 'find_by_patient'
      get 'find_by_appointment_id'
      get 'find_by_date_and_patient_gender'
      get 'confirm_appointment'
      delete 'delete_by_appointment_id'
      patch 'nurse_confirm_appointment'
      patch 'make_reschedule'
      get 'make_reschedule_table'
      patch 'make_reschedule_done'
      get 'ongoing_appointment'
      patch 'make_appointment_done'
      get 'finished_appointment'
      patch 'nurse_make_test_done'
      patch 'nurse_make_to_diagnose'
      get 'find_by_patient_id'
    end
  end
  resources :nurses do
    collection do
      get 'find_by_nurse_id'
      post 'reset_password'
      get 'get_ward_gender'
    end
  end
  resources :wards do
    collection do
      get 'get_wards_by_gender'

    end
  end
  resources :admins do
    collection do
      get 'find_by_admin_id'
    end
  end
  resources :doctors do
    collection do
      get 'find_by_doctor_id'
      post 'reset_password'
    end
  end
  resources :patients do
    collection do
      get 'find_by_patient_id'
      get 'auto_login'
      post 'login'
      patch 'make_appointment'
      get 'initial_appointment'
      patch 'make_test_done'
      get 'test_done'
      delete 'delete_by_patient_id'
      patch 'make_to_diagnose'
      get 'to_diagnose'
      patch 'doctor_make_diagnose'
      get 'to_admit_table'
      patch 'nurse_admit_patient'
      get 'admitted_patients'
      patch 'discharge_patient'
      get 'doctor_categorize_table'
      patch 'doctor_make_categorize'
      get 'doctor_change_category_treatment_table'
      patch 'doctor_change_category_treatment'
      get 'doctor_treatment_table'
      patch 'doctor_make_treatment'
      patch 'doctor_make_treatment_pause'
      get 'doctor_resume_treatment_table'
      patch 'doctor_make_treatment_resume'
      get 'doctor_make_raferral_table'
      get 'nurse_new_treatment_table'
      get 'find_by_patient_id_or_nic'
    end
  end

  post 'stafflogin', to: 'staff_login#login'
  get 'staffautologin', to: 'staff_login#staff_auto_login'
  get 'adminautologin', to: 'staff_login#admin_auto_login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
