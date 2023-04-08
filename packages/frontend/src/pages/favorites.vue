<template>
<MkStickyContainer>
	<template #header><MkPageHeader v-model:tab="tab" :actions="headerActions" :tabs="headerTabs"/></template>
	<MkSpacer :content-max="800">
		<div v-if="tab === 'favorites'">
			<MkPagination :pagination="pagination">
				<template #empty>
					<div class="_fullinfo">
						<img src="https://sda1.net/cdn/misskey/info.png" class="_ghost"/>
						<div>{{ i18n.ts.noNotes }}</div>
					</div>
				</template>

				<template #default="{ items }">
					<MkDateSeparatedList v-slot="{ item }" :items="items" :direction="'down'" :no-gap="false" :ad="false">
						<MkNote :key="item.id" :note="item.note" :class="$style.note"/>
					</MkDateSeparatedList>
				</template>
			</MkPagination>
		</div>
		<div v-else-if="tab === 'clips'">
			<XClips/>
		</div>
	</MkSpacer>
</MkStickyContainer>
</template>

<script lang="ts" setup>
import { computed, watch } from 'vue';
import MkPagination from '@/components/MkPagination.vue';
import MkNote from '@/components/MkNote.vue';
import XClips from'./my-clips/index.vue';
import XNote from '@/components/MkNote.vue';
import MkDateSeparatedList from '@/components/MkDateSeparatedList.vue';
import MkFoldableSection from '@/components/MkFoldableSection.vue';
import { i18n } from '@/i18n';
import { definePageMetadata } from '@/scripts/page-metadata';

const pagination = {
	endpoint: 'i/favorites' as const,
	limit: 10,
};

const props = withDefaults(defineProps<{
	tag?: string;
	initialTab?: string;
}>(), {
	initialTab: 'favorites',
});

let tab = $ref(props.initialTab);
let tagsEl = $shallowRef<InstanceType<typeof MkFoldableSection>>();

watch(() => props.tag, () => {
	if (tagsEl) tagsEl.toggleContent(props.tag == null);
});

const headerActions = $computed(() => []);

const headerTabs = $computed(() => [{
	key: 'favorites',
	icon: 'ti ti-star',
	title: i18n.ts.favorites,
}, {
	key: 'clips',
	icon: 'ti ti-paperclip',
	title: i18n.ts.clip,
}]);

definePageMetadata({
	title: i18n.ts.favorites,
	icon: 'ti ti-star',
});
</script>

<style lang="scss" module>
.note {
	background: var(--panel);
	border-radius: var(--radius);
}
</style>
