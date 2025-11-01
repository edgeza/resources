const Layout = ({ children }) => {
  return (
    <div className="h-screen w-screen">
      <div className=" w-full h-full">
        <div className="w-full h-full p-4 relative">{children}</div>
      </div>
    </div>
  );
};
export default Layout;
