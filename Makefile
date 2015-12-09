.PHONY: help release release-dev bump-release bump-patch bump-minor bump-major upload assert-nondirty

help:
	@echo "release:     package and upload the current version as a full release"
	@echo "release-dev: package and upload the current version as a developmental release"
	@echo "bump-major:  bump the major version number"
	@echo "bump-minor:  bump the minor version number"

release: | bump-release upload bump-patch
	git push
	git push --tags

release-dev: | assert-nondirty upload
	git tag "v$(call current_version)"
	bumpversion --message "Bump development release number" dev
	git push
	git push --tags

bump-major:
	$(call targetnext, major)

bump-minor:
	$(call targetnext, minor)

bump-patch:
	$(call targetnext, patch)

bump-release:
	bumpversion --tag --message "Release version {new_version}" release

upload:
	python setup.py sdist upload
	python setup.py bdist_wheel upload

assert-nondirty:
	python -c "from bumpversion import Git; Git.assert_nondirty()"

current_version = `grep 'current_version\s*=' setup.cfg | cut -d "=" -f 2 | sed "s/\s//g"`
next_release = `bumpversion --dry-run --verbose $(1) 2>&1 | grep -E "New version will be" | sed -r "s/^.* '//" | sed -r "s/(\.dev[0-9]+)?'//"`
targetnext = bumpversion --message "Target version $(call next_release, $(1)) for next release" $(1)
