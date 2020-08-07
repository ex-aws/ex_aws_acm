defmodule ExAws.ACM do
  @moduledoc """
  Operations for AWS Certificate Manager.

  ## Basic Usage

  ```elixir
  ExAws.ACM.request_certificate("helloworld.example.com", validation_method: "DNS") |> ExAws.request!()
  ```
  """
  @namespace "CertificateManager"

  @type certificate_arn ::
          String.t()

  @type certificate_options ::
          [
            certificate_transparency_logging_preference: String.t()
          ]

  @type domain_validation_option ::
          %{
            domain_name: String.t(),
            validation_domain: String.t()
          }

  @type filter ::
          %{
            extended_key_usage: [String.t()],
            key_types: [String.t()],
            key_usage: [String.t()]
          }

  @type import_certificate_opts ::
          [
            certificate_arn: certificate_arn,
            certificate_chain: binary,
            tags: tags
          ]

  @type list_certificates_opts ::
          [
            certificate_statuses: String.t(),
            includes: filter,
            max_items: pos_integer,
            next_token: String.t()
          ]

  @type request_certificate_opts ::
        [
          certificate_authority_arn: String.t(),
          domain_validation_options: domain_validation_option,
          idempotency_token: String.t(),
          options: certificate_options,
          subject_alternative_names: [String.t()],
          tags: tags,
          validation_method: String.t()
        ]

  @type tags ::
          [%{ key: String.t(), value: String.t() }]

  @spec add_tags_to_certificate(certificate_arn, tags) :: ExAws.Operation.JSON.t()
  def add_tags_to_certificate(certificate_arn, tags) do
    params = Keyword.new()
    params = Keyword.put(params, :CertificateArn, certificate_arn)
    params = Keyword.put(params, :Tags, tags)

    request(:add_tags_to_certificate, params)
  end

  @spec delete_certificate(certificate_arn) :: ExAws.Operation.JSON.t()
  def delete_certificate(certificate_arn) do
    request(:delete_certificate, %{ CertificateArn: certificate_arn })
  end

  @spec describe_certificate(certificate_arn) :: ExAws.Operation.JSON.t()
  def describe_certificate(certificate_arn) do
    request(:describe_certificate, %{ CertificateArn: certificate_arn })
  end

  @spec export_certificate(certificate_arn, binary) :: ExAws.Operation.JSON.t()
  def export_certificate(certificate_arn, passphrase) do
    params = Keyword.new()
    params = Keyword.put(params, :CertificateArn, certificate_arn)
    params = Keyword.put(params, :Passphrase, passphrase)

    request(:export_certificate, params)
  end

  @spec get_certificate(certificate_arn) :: ExAws.Operation.JSON.t()
  def get_certificate(certificate_arn) do
    request(:get_certificate, [CertificateArn: certificate_arn])
  end

  @spec import_certificate(binary, binary, import_certificate_opts) :: ExAws.Operation.JSON.t()
  def import_certificate(certificate, private_key, opts \\ []) do
    params = Keyword.new()
    params = Keyword.put(params, :Certificate, certificate)
    params = Keyword.put(params, :PrivateKey, private_key)
    params = Keyword.merge(params, opts)

    request(:import_certificate, params)
  end

  @spec list_certificates(list_certificates_opts) :: ExAws.Operation.JSON.t()
  def list_certificates(opts \\ []) do
    request(:list_certificates, opts)
  end

  @spec list_tags_for_certificate(certificate_arn) :: ExAws.Operation.JSON.t()
  def list_tags_for_certificate(certificate_arn) do
    request(:list_tags_for_certificate, [CertificateArn: certificate_arn])
  end

  @spec remove_tags_from_certificate(certificate_arn, tags) :: ExAws.Operation.JSON.t()
  def remove_tags_from_certificate(certificate_arn, tags) do
    params = Keyword.new()
    params = Keyword.put(params, :CertificateArn, certificate_arn)
    params = Keyword.put(params, :Tags, tags)

    request(:remove_tags_from_certificate, params)
  end

  @spec renew_certificate(String.t()) :: ExAws.Operation.JSON.t()
  def renew_certificate(certificate_arn) do
    request(:renew_certificate, [CertificateArn: certificate_arn])
  end

  @spec request_certificate(certificate_arn, request_certificate_opts) :: ExAws.Operation.JSON.t()
  def request_certificate(domain_name, opts \\ []) do
    params = Keyword.new()
    params = Keyword.put(params, :DomainName, domain_name)
    params = Keyword.merge(params, opts)

    request(:request_certificate, params)
  end

  @spec resend_validation_email(certificate_arn, String.t(), String.t()) :: ExAws.Operation.JSON.t()
  def resend_validation_email(certificate_arn, domain, validation_domain) do
    params = Keyword.new()
    params = Keyword.put(params, :CertificateArn, certificate_arn)
    params = Keyword.put(params, :Domain, domain)
    params = Keyword.put(params, :ValidationDomain, validation_domain)

    request(:resend_validation_email, params)
  end

  @doc false
  @spec target(String.t()) :: String.t()
  def target(name) do
    "#{@namespace}.#{name}"
  end

  @spec update_certificate_options(certificate_arn, certificate_options) :: ExAws.Operation.JSON.t()
  def update_certificate_options(certificate_arn, options) do
    params = Keyword.new()
    params = Keyword.put(params, :CertificateArn, certificate_arn)
    params = Keyword.put(params, :Options, options)

    request(:update_certificate_options, params)
  end

  defp request(operation, params, opts \\ %{}) do
    data = ExAws.Utils.camelize_keys(params, deep: true)

    opts = Map.merge(%{ data: data, headers: headers(operation) }, opts)

    ExAws.Operation.JSON.new(:acm, opts)
  end

  defp headers(operation) do
    target = Atom.to_string(operation)
    target = Macro.camelize(target)

    headers = []
    headers = headers ++ [{ "content-type", "application/x-amz-json-1.1" }]
    headers = headers ++ [{ "x-amz-target", target(target) }]

    headers
  end
end
