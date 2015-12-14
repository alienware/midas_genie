require 'rails_helper'

module MidasGenie
  describe Option do
    describe '# Associations' do
      it { should belong_to(:midas_question) }
    end

    describe '# Validations' do
      it { should validate_presence_of(:midas_question) }
    end
  end
end
