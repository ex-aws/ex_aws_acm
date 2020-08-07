defmodule ExAws.ACMTest do
  use ExUnit.Case, async: true

  test "add_tags_to_certificate/2" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateArn", "xxx")
    expected = Map.put(expected, "Tags", [%{ "Key" => "yyy", "Value" => "zzz" }])

    result = ExAws.ACM.add_tags_to_certificate("xxx", [%{key: "yyy", value: "zzz"}])

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("AddTagsToCertificate") } in result.headers
  end

  test "delete_certificate/1" do
    expected = %{ "CertificateArn" => "xxx" }

    result = ExAws.ACM.delete_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("DeleteCertificate") } in result.headers
  end

  test "describe_certificate/1" do
    expected = %{ "CertificateArn" => "xxx" }

    result = ExAws.ACM.describe_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("DescribeCertificate") } in result.headers
  end

  test "export_certificate/2" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateArn", "xxx")
    expected = Map.put(expected, "Passphrase", "yyy")

    result = ExAws.ACM.export_certificate("xxx", "yyy")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ExportCertificate") } in result.headers
  end

  test "get_certificate/1" do
    expected = %{ "CertificateArn" => "xxx" }

    result = ExAws.ACM.get_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("GetCertificate") } in result.headers
  end

  test "import_certificate/3 with default arguments" do
    expected = Map.new()
    expected = Map.put(expected, "Certificate", "xxx")
    expected = Map.put(expected, "PrivateKey", "yyy")

    result = ExAws.ACM.import_certificate("xxx", "yyy")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ImportCertificate") } in result.headers
  end

  test "import_certificate/3 with optional arguments" do
    expected = Map.new()
    expected = Map.put(expected, "Certificate", "xxx")
    expected = Map.put(expected, "PrivateKey", "yyy")
    expected = Map.put(expected, "CertificateArn", "zzz")
    expected = Map.put(expected, "CertificateChain", "aaa")
    expected = Map.put(expected, "Tags", [%{ "Key" => "bbb", "Value" => "ccc" }])

    opts = [certificate_arn: "zzz", certificate_chain: "aaa", tags: [%{ key: "bbb", value: "ccc" }]]

    result = ExAws.ACM.import_certificate("xxx", "yyy", opts)

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ImportCertificate") } in result.headers
  end

  test "list_certificates/1 with default arguments" do
    result = ExAws.ACM.list_certificates()

    assert %{} == result.data
    assert { "x-amz-target", ExAws.ACM.target("ListCertificates") } in result.headers
  end

  test "list_certificates/1 with optional arguments" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateStatuses", ["xxx"])
    expected = Map.put(expected, "Includes", %{ "ExtendedKeyUsage" => "yyy", "KeyTypes" => "zzz", "KeyUsage" => "aaa" })
    expected = Map.put(expected, "MaxItems", 1)
    expected = Map.put(expected, "NextToken", "bbb")

    opts = Keyword.new()
    opts = Keyword.put(opts, :certificate_statuses, ["xxx"])
    opts = Keyword.put(opts, :includes, %{ extended_key_usage: "yyy", key_types: "zzz", key_usage: "aaa" })
    opts = Keyword.put(opts, :max_items, 1)
    opts = Keyword.put(opts, :next_token, "bbb")

    result = ExAws.ACM.list_certificates(opts)

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ListCertificates") } in result.headers
  end

  test "list_tags_for_certificate/1" do
    expected = %{ "CertificateArn" => "xxx" }

    result = ExAws.ACM.list_tags_for_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ListTagsForCertificate") } in result.headers
  end

  test "remove_tags_from_certificate/2" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateArn", "xxx")
    expected = Map.put(expected, "Tags", [%{ "Key" => "yyy", "Value" => "zzz" }])

    result = ExAws.ACM.remove_tags_from_certificate("xxx", [%{ key: "yyy", value: "zzz" }])

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("RemoveTagsFromCertificate") } in result.headers
  end

  test "renew_certificate/1" do
    expected = %{ "CertificateArn" => "xxx" }

    result = ExAws.ACM.renew_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("RenewCertificate") } in result.headers
  end

  test "request_certificate/2 with default arguments" do
    expected = %{ "DomainName" => "xxx" }

    result = ExAws.ACM.request_certificate("xxx")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("RequestCertificate") } in result.headers
  end

  test "request_certificate/2 with optional arguments" do
    expected = Map.new()
    expected = Map.put(expected, "DomainName", "xxx")
    expected = Map.put(expected, "CertificateAuthorityArn", "yyy")
    expected = Map.put(expected, "DomainValidationOptions", [%{ "DomainName" => "zzz", "ValidationDomain" => "aaa" }])
    expected = Map.put(expected, "IdempotencyToken", "bbb")
    expected = Map.put(expected, "Options", %{ "CertificateTransparencyLoggingPreference" => "ccc" })
    expected = Map.put(expected, "SubjectAlternativeNames", ["ddd"])
    expected = Map.put(expected, "Tags", [%{ "Key" => "ddd", "Value" => "eee" }])
    expected = Map.put(expected, "ValidationMethod", "fff")

    opts = Keyword.new()
    opts = Keyword.put(opts, :certificate_authority_arn, "yyy")
    opts = Keyword.put(opts, :domain_validation_options, [%{ domain_name: "zzz", validation_domain: "aaa" }])
    opts = Keyword.put(opts, :idempotency_token, "bbb")
    opts = Keyword.put(opts, :options, %{ certificate_transparency_logging_preference: "ccc" })
    opts = Keyword.put(opts, :subject_alternative_names, ["ddd"])
    opts = Keyword.put(opts, :tags, [%{ key: "ddd", value: "eee" }])
    opts = Keyword.put(opts, :validation_method, "fff")

    result = ExAws.ACM.request_certificate("xxx", opts)

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("RequestCertificate") } in result.headers
  end

  test "resend_validation_email/3" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateArn", "xxx")
    expected = Map.put(expected, "Domain", "yyy")
    expected = Map.put(expected, "ValidationDomain", "zzz")

    result = ExAws.ACM.resend_validation_email("xxx", "yyy", "zzz")

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("ResendValidationEmail") } in result.headers
  end

  test "update_certificate_options/2" do
    expected = Map.new()
    expected = Map.put(expected, "CertificateArn", "xxx")
    expected = Map.put(expected, "Options", %{ "CertificateTransparencyLoggingPreference" => "yyy" })

    result = ExAws.ACM.update_certificate_options("xxx", %{ certificate_transparency_logging_preference: "yyy" })

    assert expected == result.data
    assert { "x-amz-target", ExAws.ACM.target("UpdateCertificateOptions") } in result.headers
  end
end
