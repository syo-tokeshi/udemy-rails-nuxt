class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        max = 255
        format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/

        # 合致していなければ
        record.errors.add(attribute, :invalid) unless format =~ value 

        # 255文字を超えていたら
        record.errors.add(attribute, :too_long, count: max) if value.length > max

        # 登録済みであれば、エラーを出す
        record.errors.add(attribute, :taken) if record.email_activated?
    end
end