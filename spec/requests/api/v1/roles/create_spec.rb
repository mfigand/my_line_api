# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'create role requests' do
#   describe 'POST /api/v1/users/:user_id/roles' do
#     subject(:endpoint_call) do
#       post "/api/v1/users/#{superadmin.id}/roles",
#            params: params,
#            headers: { 'Authentication' => auth_token }
#     end

#     let(:superadmin) { create(:user) }
#     let(:role) { superadmin.roles.create(name: 'superadmin') }
#     let(:timeline) { create(:timeline) } 
#     let(:params) do
#       { name: 'teller',
#         resource: 'Timeline',
#         resource_id: timeline.id }
#     end
#     let(:auth_token) { JsonWebToken.encode(user_id: teller.id) }
#     let(:params) do
#       { title: 'Funny role',
#         date: Time.now.utc - 5.days,
#         teller_title: 'Uncle',
#         timeline_id: timeline_id,
#         tags: %w[tag_1 tag_2],
#         description: 'role description' }
#     end
#     let(:data_response) { JSON.parse(response.body)['data'] }

#     context '#create' do
#       it do
#         expect { subject }.to change { role.count }.by(1)
#         expect(response).to have_http_status(200)
#         expect(data_response).to include('title' => params[:title],
#                                          'date' => params[:date].strftime('%F'),
#                                          'protagonist_id' => timeline.protagonist.id,
#                                          'teller_id' => teller.id,
#                                          'teller_title' => params[:teller_title],
#                                          'timeline_id' => timeline.id,
#                                          #  'tags' => params[:tags],
#                                          'description' => params[:description])
#       end
#     end

#     context 'user not allowed to create' do
#       let(:user_not_allow_to_create) { create(:user) }

#       let(:not_allowed_user_token) { JsonWebToken.encode(user_id: user_not_allow_to_create.id) }
#       let(:auth_token) { not_allowed_user_token }

#       it do
#         subject
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end

#     context "can't find timeline" do
#       let(:timeline_id) { '0' }

#       it do
#         expect { subject }.to change { role.count }.by(0)
#         expect(response).to have_http_status(:not_found)
#       end
#     end

#     context 'invalid schema' do
#       let(:params) {}

#       it do
#         subject
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(data_response).to eq("The property '#/role' did not contain a required property of 'date'")
#       end
#     end

#     context 'invalid token' do
#       let(:auth_token) { '' }

#       it do
#         subject
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end
# end
