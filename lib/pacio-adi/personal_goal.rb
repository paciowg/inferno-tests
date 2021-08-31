module PacioAdi
    class PersonalGoal < Inferno::TestGroup
      title 'Personal Goal (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Personal Goal profile.'
      id :pacio_adi_personal_goal
  
      test do
        title 'Server returns correct Personal Goal resource from the Personal Goal read interaction'
        description %(
          This test will verify that Personal Goal resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalGoal
  
      input :personal_goal_id
      makes_request :personal_goal
  
      run do
        fhir_read(:personal_goal, personal_goal_id, name: :personal_goal)
  
        assert_response_status(200)
          assert_resource_type(:personal_goal)
          assert resource.id == personal_goal_id,
                 "Requested resource with id #{personal_goal_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Personal Goal resoure that matches the Personal Goal (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Personal Goal resource returned from the server matches the Personal Goal (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalGoal
        uses_request :personal_goal
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalGoal')
        end
      end
  
      test do
        title 'Server supports searching Personal Goal (PACIO Advance Directives) profile by Personal Goal ID'
        description %(
          This test will validate that the FHIR server supports searching Personal Goal by ID (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PersonalGoal
  
        uses_request :personal_goal
  
        run do
          fhir_search :personal_goal, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end