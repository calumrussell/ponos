
export const sortByPosition = (arr: any) => {
  const positionOrder = [
    'GK',
    'DL',
    'DC',
    'DR',
    'DML',
    'DMC',
    'DMR',
    'ML',
    'MC',
    'MR',
    'AML',
    'AMC',
    'AMR',
    'FWL',
    'FW',
    'FWR',
    'Sub'
  ];

  const orderForIndexVals = positionOrder.slice(0).reverse();
  arr.sort((a: any, b: any) => {
    const aIndex = -orderForIndexVals.indexOf(a.position);
    const bIndex = -orderForIndexVals.indexOf(b.position);
    return aIndex - bIndex;
  });
}
