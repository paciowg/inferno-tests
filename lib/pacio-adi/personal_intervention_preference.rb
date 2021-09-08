module PacioAdi
    class PersonalInterventionPreference < Inferno::TestGroup
      title 'Personal Intervention Preference (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Personal Intervention Preference profile.'
      id :pacio_adi_personal_intervention_preference
  
      test do
        title 'Server returns correct Personal Intervention Preference resource from the Personal Intervention Preference read interaction'
        description %(
          This test will verify that Personal Intervention Preference resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalInterventionPreference
  
      input :personal_intervention_preference_id
      makes_request :personal_intervention_preference
  
      run do
        fhir_read(:observation, personal_intervention_preference_id, name: :personal_intervention_preference)
  
        assert_response_status(200)
          assert_resource_type(:observation)
          assert resource.id == personal_intervention_preference_id,
                 "Requested resource with id #{personal_intervention_preference_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Personal Intervention Preference resoure that matches the Personal Intervention Preference (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Personal Intervention Preference resource returned from the server matches the Personal Intervention Preference (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalInterventionPreference
        uses_request :personal_intervention_preference
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalInterventionPreference')
        end
      end
  
    end
  end