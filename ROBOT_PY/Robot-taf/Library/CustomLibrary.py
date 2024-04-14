from robot.api.deco import keyword


@keyword('Compare Two Lists By Ignoring Order')
def lists_have_same_elements(list1, list2):
    return sorted(list1) == sorted(list2)
