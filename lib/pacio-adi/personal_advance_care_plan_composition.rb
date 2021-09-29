module PacioAdi
    class PersonalAdvanceCarePlanComposition < Inferno::TestGroup
      title 'Personal Advance Care Plan Composition (PACIO Advance Directives) Tests'
        
      description 'Verify support for the server capabilities required by the Personal Advance Care Plan Composition profile.'
      id :pacio_adi_personal_advance_care_plan_composition
  
      test do
        title 'Server returns correct Personal Advance Care Plan Composition resource from the Personal Advance Care Plan Composition read interaction'
        description %(
          This test will verify that Personal Advance Care Plan Composition resources can be read from the server.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PACPComposition
  
      input :personal_advance_care_plan_composition_id
      makes_request :personal_advance_care_plan_composition
  
      run do
        fhir_read(:padiheader, personal_advance_care_plan_composition_id, name: :personal_advance_care_plan_composition)
  
        assert_response_status(200)
          assert_resource_type(:padiheader)
          assert resource.id == personal_advance_care_plan_composition_id,
                 "Requested resource with id #{personal_advance_care_plan_composition_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Personal Advance Care Plan Composition resoure that matches the Personal Advance Care Plan Composition (PACIO Advance Directives) profile'
        description %(
          This test will validate that the Personal Advance Care Plan Composition resource returned from the server matches the Personal Advance Care Plan Composition (PACIO Advance Directives) profile.
        )
        # link http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PACPComposition
        uses_request :personal_advance_care_plan_composition
  
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-adi/StructureDefinition/PADI-PACPComposition')
        end
      end
  
    end
  end