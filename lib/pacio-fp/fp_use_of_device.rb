module PacioFp
    class FpUseOfDevice < Inferno::TestGroup
      title 'PACIO Functional Performance Use of Device Tests'
        
      description 'Verify support for the server capabilities required by the Functional Performance Use of Device profile.'
      id :pacio_fp_use_of_device
  
      input :fp_use_of_device_id
  
      test do
        title 'Server returns correct Functional Performance Use of Device resource from the read interaction'
        description %(
          This test will verify that Functional Performance Use of Device resources can be read from the server.
        )
  
      makes_request :DeviceUseStatement
  
      run do
        fhir_read(:DeviceUseStatement, fp_use_of_device_id, name: :DeviceUseStatement)
  
        assert_response_status(200)
          assert_resource_type(:DeviceUseStatement)
          assert resource.id == fp_use_of_device_id,
                 "Requested resource with id #{fp_use_of_device_id}, received resource with id #{resource.id}"
        end
      end
  
      test do
        title 'Server returns Functional Performance Use of Device resoure that matches the PACIO Functional Performance Use of Device profile'
        description %(
          This test will validate that the Functional Performance Use of Device resource returned from the server matches the PACIO Functional Performance Use of Device profile.
        )
        uses_request :DeviceUseStatement
        
        run do
          assert_valid_resource(profile_url: 'http://hl7.org/fhir/us/pacio-fp/StructureDefinition/fp-use-of-device')
        end
      end
  
  
      test do
        title 'Server supports searching PACIO Functional Performance Use of Device profile by ID'
        description %(
          This test will validate that the FHIR server supports searching PACIO Functional Performance Use of Device profile by ID.
        )
  
        uses_request :DeviceUseStatement
  
        run do
          fhir_search :DeviceUseStatement, params: { _id: resource.id }
  
          assert_response_status(200)
          assert_resource_type('Bundle')
        end
      end
  
    end
  end