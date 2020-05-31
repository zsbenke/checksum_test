require "application_system_test_case"

class ChecksumTest < ApplicationSystemTestCase
  setup do
    @fixture1 = 'foo bar baz wibble fizzbuzz fizz buzz'
    @fixture2 = 'The quick brown fox jumps over the lazy dog'
    @checksum1 = Checksum.new @fixture1
    @checksum2 = Checksum.new @fixture2
  end

  test 'should generate checksum' do
    visit new_checksum_url
    assert_text I18n.t('checksum.titles.new')
    assert_no_selector '.checksum_output.calculated'

    fill_in I18n.t('helpers.label.checksum.original'), with: @fixture1
    click_button I18n.t('checksum.actions.create')
    assert_selector '.checksum_output.calculated'
    within '.checksum_output' do
      assert_text @checksum1.to_s
    end

    fill_in I18n.t('helpers.label.checksum.original'), with: @fixture2
    click_button I18n.t('checksum.actions.create')
    assert_selector '.checksum_output.calculated'
    within '.checksum_output' do
      assert_text @checksum2.to_s
    end
  end

  test 'should remove green output highlight when empty text was sent' do
    visit new_checksum_url
    assert_text I18n.t('checksum.titles.new')
    assert_no_selector '.checksum_output.calculated'
    within '.checksum_output' do
      assert_text Checksum.new.to_s
    end

    fill_in I18n.t('helpers.label.checksum.original'), with: @fixture1
    click_button I18n.t('checksum.actions.create')
    within '.checksum_output' do
      assert_text @checksum1.to_s
    end
    assert_selector '.checksum_output.calculated'

    fill_in I18n.t('helpers.label.checksum.original'), with: ''
    click_button I18n.t('checksum.actions.create')
    assert_no_selector '.checksum_output.calculated'
    within '.checksum_output' do
      assert_text Checksum.new.to_s
    end
  end
end
