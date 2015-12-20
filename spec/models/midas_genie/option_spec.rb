# == Schema Information
#
# Table name: midas_genie_options
#
#  id                      :integer          not null, primary key
#  title                   :text             not null
#  description             :text
#  remark                  :text
#  midas_genie_question_id :integer
#  deleted_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

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
