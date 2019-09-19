module HttpStore
  module Helpers
    module Responseable
      # check response message is right, if is right
      def response_status_check
        status_code == 200
      end

      def json_response?
        response_headers_hash['content_type'].to_s =~ /json/
      end

      def build_response
        @meta.status_code      = response_obj.code
        @meta.response         = json_safe_parse(response_obj.body)
        @meta.response_headers = response_obj.headers

        @meta.response_valid = !!response_status_check
        @meta.response_data  = build_response_data
        raise HttpStore::RequestError, '三方请求异常, 请与管理员联系' if response_data.blank?
      end

      def build_response_data
        response_valid ? 'success' : 'error'
      end
    end
  end
end
