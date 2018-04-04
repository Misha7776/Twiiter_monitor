require 'rails_helper'
require 'spec_helper'
require 'helpers/axlsx_context'

describe 'twitter_users/export_users_to_exel.xlsx.axlsx' do
  include_context 'axlsx'

  before :each do
    # all the instance variables here are the one used in 'shared/_total_request.xlsx.axlsx'
    # @widget = mock_model(TwitterUser, name: 'Twitter Users')
    # @message_counts = Struct.new(:count_all, :positives, :negatives, :neutrals).new(42, 23, 15, 25)
    # @twitter_users = TwitterUser.all
  end

  it 'has a title line mentioning the widget' do
    wb = render_template({header_style: nil})
    # sheet = wb.sheet_by_name('Twitter Users')
    binding.pry
    # expect(sheet).to have_header_cell(%w[Name Owner Followers Following Description])
    expect(wb.worksheets.length).to eq(1)

  end

  # it 'exports the message counts' do
  #   wb = render_template
  #   sheet = wb.sheet_by_name('Twitter Users')
  #   expect(sheet).to have_cells(['Toutes tonalités', 'Tonalité positive', 'Tonalité négative', 'Tonalité neutre']).in_row(2)
  #   expect(sheet).to have_cells([42, 23, 15, 25]).in_row(3)
  # end
end

