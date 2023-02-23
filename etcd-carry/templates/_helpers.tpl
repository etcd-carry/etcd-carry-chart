{{/*
Expand the name of the chart.
*/}}
{{- define "etcd-carry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "etcd-carry.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "etcd-carry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "etcd-carry.labels" -}}
helm.sh/chart: {{ include "etcd-carry.chart" . }}
{{ include "etcd-carry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "etcd-carry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "etcd-carry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "etcd-carry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "etcd-carry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the existing etcd PKI Configmap name (if it exists)
otherwise fail
*/}}
{{- define "etcd-carry.pki" -}}
{{- if .Values.existingPkiConfigmap }}
{{- printf "%s" (tpl .Values.existingPkiConfigmap $) }}
{{- else }}
{{- fail "etcd PKI configmap should be created in advance"}}
{{- end }}
{{- end }}

{{/*
Return the existing confimap (if it exists)
otherwise return the default
*/}}
{{- define "etcd-carry.config" -}}
{{- if .Values.existingConfigmap }}
{{- printf "%s" (tpl .Values.existingConfigmap $) }}
{{- else }}
{{- include "etcd-carry.name" . }}
{{- end }}
{{- end }}
