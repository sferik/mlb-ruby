module MLB
  # Module to mark errors that are safe to retry.
  # Include this in error classes where automatic retry logic is appropriate,
  # such as transient network issues or temporary server unavailability.
  #
  # @api public
  # @example Checking if an error is retryable
  #   begin
  #     client.get("teams")
  #   rescue MLB::Error => e
  #     retry if e.is_a?(MLB::Retryable) && attempts < 3
  #     raise
  #   end
  module Retryable; end
end
