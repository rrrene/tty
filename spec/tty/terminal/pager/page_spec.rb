# encoding: utf-8

require 'spec_helper'

describe TTY::Terminal::Pager, '#page' do
  let(:text)   { "a\n" }
  let(:shell)  { TTY.shell }
  let(:system) { TTY::System }
  let(:pager)  { double(:pager, :page => nil) }
  let(:basic_pager)  { TTY::Terminal::BasicPager }
  let(:system_pager) { TTY::Terminal::SystemPager }

  subject { described_class }

  before { allow(shell).to receive(:tty?).and_return(true) }

  context 'when not tty' do
    before { allow(shell).to receive(:tty?).and_return(false) }

    it "doesn't page" do
      expect(subject.page(text)).to eql(nil)
    end
  end

  context 'when not unix' do
    before  { allow(system).to receive(:unix?).and_return(false) }

    it 'pages with simple pager' do
      expect(basic_pager).to receive(:new).with(text).and_return(pager)
      subject.page(text)
    end
  end

  context 'when unix and available' do
    before  {
      allow(system).to receive(:unix?).and_return(true)
      allow(subject).to receive(:available?).and_return(true)
    }

    it 'pages with system pager' do
      expect(system_pager).to receive(:new).with(text).and_return(pager)
      subject.page(text)
    end
  end
end
