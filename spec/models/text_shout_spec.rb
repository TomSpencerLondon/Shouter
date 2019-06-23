# frozen_string_literal: true

require 'rails_helper'

describe TextShout do

  let!(:subject) do
    described_class
  end

  context 'with body' do
    it 'is valid' do
      text_shout = subject.create(body: "Hello! This is a text shout.")
      expect(text_shout.valid?).to eq(true)
    end
  end

  context 'without body' do
    it 'is invalid' do
      text_shout = subject.create(body: nil)
      expect(text_shout.valid?).to eq(false)
    end
  end
end