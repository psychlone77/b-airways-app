

async function getData() {
  const res = await fetch("http://localhost:3000/api");
  // The return value is *not* serialized
  // You can return Date, Map, Set, etc.

  if (!res.ok) {
    // This will activate the closest `error.js` Error Boundary
    throw new Error("Failed to fetch data");
  }
  return res.json();
}

export default async function AboutUs() {
  const data = await getData();
  //console.log(data);
  return (
    <div className="">
      <div className="">
        <h1 className=" font-nunito font-semibold text-center text-8xl">We are B Airways</h1>
        <img
          src="airplane.jpg"
          alt=""
          className="``"
        />
        <div className="list">
          <div className="infoList">
            <span>Email:</span>
            <span>{data.airline_email}</span>
          </div>
          <div className="infoList">
            <span>Contact Us:</span>
            <span>{data.airline_hotline}</span>
          </div>
          <div className="infoList">
            <span>Address:</span>
            <span>{data.address}</span>
          </div>
        </div>
      </div>
    </div>
  );
}
