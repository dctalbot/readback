# frozen_string_literal: true

# @see SubRequest
class SubRequestDecorator < Draper::Decorator
  delegate_all

  # @return [String] e.g. '4pm'
  def time
    at.strftime '%l %p'
  end

  def html_class
    'highlighted' if needs_sub_in_group?
  end
end
