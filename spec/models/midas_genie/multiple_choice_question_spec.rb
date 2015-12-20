# == Schema Information
#
# Table name: midas_genie_questions
#
#  id          :integer          not null, primary key
#  title       :text             not null
#  description :text
#  remark      :text
#  type        :string           not null
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

module MidasGenie
  describe MultipleChoiceQuestion do
    describe '# Associations' do
      it { should have_many :midas_options }
    end
  end
end
