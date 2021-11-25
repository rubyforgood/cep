module Mutations
  class UpsertSurveyQuestionResponse < Base::Mutation
    null true

    argument :survey_response_id, ID, required: true
    argument :question_id, ID, required: true
    argument :option_ids, [ID], required: false
    argument :reply, String, required: false

    field :question_response, Types::SurveyQuestionResponseType, null: false

    def resolve(survey_response_id:, question_id:, reply:, option_ids: [])
      ActiveRecord::Base.transaction do
        question_response = SurveyQuestionResponse.find_or_create_by!(
          survey_response_id: survey_response_id,
          survey_question_id: question_id
        )
        question_response.update!(reply: reply)
        question_response.option_responses.destroy_all

        option_ids.each do |option|
          SurveyQuestionOptionResponse.create!(
            survey_question_response_id: question_response.id,
            survey_question_option_id: option
          )
        end
        {question_response: question_response}
      end
    end
  end
end
