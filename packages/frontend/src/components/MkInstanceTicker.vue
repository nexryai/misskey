<template>
<div :class="$style.root" :style="bg">
	<img v-if="faviconUrl" :class="$style.icon" :src="faviconUrl"/>
</div>
</template>

<script lang="ts" setup>
import { } from 'vue';
import { instanceName } from '@/config';
import { instance as Instance } from '@/instance';
import { getProxiedImageUrlNullable } from '@/scripts/media-proxy';

const props = defineProps<{
	instance?: {
		faviconUrl?: string
		name: string
		themeColor?: string
	}
}>();

// if no instance data is given, this is for the local instance
const instance = props.instance ?? {
	name: instanceName,
	themeColor: (document.querySelector('meta[name="theme-color-orig"]') as HTMLMetaElement).content,
};

const faviconUrl = $computed(() => props.instance ? getProxiedImageUrlNullable(props.instance.faviconUrl, 'preview') : getProxiedImageUrlNullable(Instance.iconUrl, 'preview') ?? getProxiedImageUrlNullable(Instance.faviconUrl, 'preview') ?? '/favicon.ico');

const themeColor = instance.themeColor ?? '#777777';

const bg = {
	background: `transparent`,
};
</script>

<style lang="scss" module>
$height: 2ex;

.root {
	display: inline;
	align-items: center;
	overflow: clip;
	padding-left: 10px;
}

.icon {
	height: $height;
	vertical-align: middle;
}

.name {
	margin-left: 4px;
	line-height: 1;
	font-size: 0.9em;
	font-weight: bold;
	white-space: nowrap;
	overflow: visible;
}
</style>
