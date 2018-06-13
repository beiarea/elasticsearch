{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch-single-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | replace "_" "-" | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch-single-node.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if .Values.prependReleaseName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | replace "_" "-" | trimSuffix "-" -}}
{{- else -}}
{{- $name | trunc 63 | replace "_" "-" | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
