require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city)}  
    it { should validate_presence_of(:state)}  
      
   
  end
end
